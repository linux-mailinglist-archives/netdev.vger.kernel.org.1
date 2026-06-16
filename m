Return-Path: <netdev+bounces-299775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jQnLF58LMWocawUAu9opvQ
	(envelope-from <netdev+bounces-299775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:38:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B624E68D388
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:38:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=a7BhXtlj;
	dkim=pass header.d=redhat.com header.s=google header.b=p7Hm3EcC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299775-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299775-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6198830AD6A4
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106504183BE;
	Tue, 16 Jun 2026 08:35:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960429346F
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 08:35:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598943; cv=pass; b=RnODW/qWiA7DD1hgV/Wi1nAzjZCsI5IvFMZxmIe8XI3c8ywDcs+BC0VGuJm5QUdUML4vMCNmeIpWxc+E7rd1BtXiFxPrpq4MrcKD5oO1Bzi8D1U+8t8RiB28sVwcUwEypZQ46mSVFhEwU4CI6vwio2K9JTzcFpyhg0IHuqDjfzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598943; c=relaxed/simple;
	bh=BYNWjDrljSu++9EAAQn7raDvnykGXPVajd+F+x7ETEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru9oh7THKQ7ZzcpW15u1rFNxYqJ30yHpq6JELgHvUCwgS5Gm2elQ8dWRFPkL6WGPY9bP/v6Nd5Oz9ko9/1TOdI93j3OkEuJcb85DPpucPTkpqtg6FI6F9P4z1HB14OA0agkqb1VORsgn1SSp5Ei829OFTohYO1N3MxXjYht19X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7BhXtlj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p7Hm3EcC; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781598940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3efmxi08uqzcSZPF9PPWMJrIYYHz/b0LBw8WBsw1Ns=;
	b=a7BhXtljvz6u03zMLQoclxdG08c5zDkuBMR53bSEdeEQb/dB7RlAlgHffSwq1HlDXTm9e9
	f512cLLTn/kY5GdkgFemrZA39yB35uot6XxfGmX8w8AocHvZnYREQfFSB+IthXMHcd5WKG
	Yz8qJ4FrnqStBFvVeWFU25LbHnEej4E=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-RRwP3GZDMH2hb69ABbDUWQ-1; Tue, 16 Jun 2026 04:35:39 -0400
X-MC-Unique: RRwP3GZDMH2hb69ABbDUWQ-1
X-Mimecast-MFC-AGG-ID: RRwP3GZDMH2hb69ABbDUWQ_1781598939
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7f010ade153so36193717b3.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781598939; cv=none;
        d=google.com; s=arc-20240605;
        b=dCPdtrp0QPu/39rKLbmiPa3N/9HhPebZcDcnTl/nJqtxfws+ybo/CEeXUpG4UepOn7
         oOHjQ9in984nIuNl5necfOZOkroFnGDG7qtobkbvWeDFtJg7QIHQlgFlfySsaWLWpxy9
         WztLdRHisqKgU0sr02QbZxhVol4JUsQvLFPIHow9IzcH/zZza/JFTYMqnNmsCz3geLgq
         y4RL1OlSDdgwKAxOhoBtYYZUkDYwU6KsAWjv9GWMIL6dt+7YVNtrez8WrvjZw57Q++eL
         FhKJijsjw8AAomLfKqEfsdbfAcp4KdfI7lWTll5qfWbV8sPftq/Nvx26Bkx4KwbDQzNr
         lYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3efmxi08uqzcSZPF9PPWMJrIYYHz/b0LBw8WBsw1Ns=;
        fh=J1YafrqE46VGyRBoDTW7ApKjj5wDvihW8fGK2Unqbo4=;
        b=Cvk6jC+hUIHb31RGHAqWXPWEtsY6+64xPyeSRrVaFNiAxUdnfYmCUbsv7vfLrNl7WJ
         Y1EMt3iAAkQnOHWMdDCVNCFeJhWQOP0XeeJTZ0Tmx1dEjnh+7ndPIZ9UK5Z35J7qo8Xo
         keFZkfSkYs1OKsuBM89In779C1dfTcX+tGPf5vlvuWaY7Fb+homui2ECWi36VQq9kppF
         QRAtGpKefDp3ejKw7/tPpwK3eyAN9mCUpS4WxmYgupKbZJXtw8HtJQtPt8NTEyQ2QKnl
         GabtDtvZJWrF+NA/w/Z0JlvUYfnHHktzPXau9vzAchlJABRd/MvagdqbhhufgywMy7yJ
         XeHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781598939; x=1782203739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3efmxi08uqzcSZPF9PPWMJrIYYHz/b0LBw8WBsw1Ns=;
        b=p7Hm3EcCHsC7NRDkgoSEUzvSFh2zVLb1yEkrlRtwYcUZxc49UMF7ojOlFkKGiF9Vin
         33VZm1QXXfBOqYxZC7oPgbxkkojUpm3O/DzYZy6wCUZJ7XMQZqYv5LXFk14NOCLpOGDQ
         dXp+WPy2QmjR/V2ZoIAMQk/Zl4rX/is8933CEjj069flVeAFmrMm3TvMJJdQ9Tvic3rG
         jcqP2NMDhvBD8X4W8Cw9kInRqOq3CiySPZDEzFzvNaRowbuxcODvvdU9fB/BJF8FTf+Q
         7GeNHZIEZ28AvN0kdnzjhM9N+jqCebcFISfl6a8wZpiFaphaMPIzMHreJTBz3jxoxzj7
         HXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781598939; x=1782203739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3efmxi08uqzcSZPF9PPWMJrIYYHz/b0LBw8WBsw1Ns=;
        b=XPY6idK6Iurrmk5EQN12nrJPdBJqpm48CJZcfCq/fK6M+9eORdPzDBQlfAP7vDGsp4
         MCPEqBhX8BoPXXeW3V3GyymV8RRc6plDGSzZOggLk6ZmXJlmWZqm4om8B/AoxSn7nPN5
         iIBYerinHqJ7+n9l9a8irTEP3XWFvY/ij2VJfIwN2K54HTwAB/jnBVkWwPX50eTTqz3j
         c7xSVErNSHcey8nBdleji5eEY4Pn0EtHlKbvZ8Cq+gCD+ROUgg59HWY72UGFd14gzuPK
         QJM8c3PqZfwNwAFXNEx6vSjE8UEkSpU+aKQzCZDGh8PAcp8UQyuIIypjKVTPKGkR4tTN
         xdUw==
X-Forwarded-Encrypted: i=1; AFNElJ8VOKXUT7XQqTL9iESfm8BmyMmINU2uXfdbYmR2WQVLb5bIMq3pJ03bAUXWdrb34oAXeqF+Vec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/iDo/m2x2cLKkUeeDUsOQ9/0sBcEgHEC9KLoYj9yybyNg/4b
	/x+wbyLmsB+yUN1sJ17iVkqiUAYMpoTecUx6Hw26lmdDiK6SGMn824SWPbpGjFmsDHuI4Zm+JbZ
	jAwFy0ptKrm9apfLyqLW3nS/CpsPLjIqX5smjVU7stJgXVdf70w+Jds7um0IETVmdk2DJez/Ql4
	/ZmSreOA5S/F9xPHc936vyemRRd/8+VSQf
X-Gm-Gg: Acq92OHIw0TgUd8SzEFRV4iVyuSBckV18ZPpGKXl/tJJNwiFTIjN6mc7OaJH+oG4Jvy
	ld6v1lTgbvMZU/qo8AEvpyblebtaiNkAx5U88hAY6suN7EogruYQ4dKgjS5fgobgT+RIMCVZJ+C
	3IhIY2qN2utoghWEXnaAtRJv8AuFGwrCuMBa4wc5M747jGmXHwro7yRQHvgzodabLhj4LtyCxrt
	hSriQ==
X-Received: by 2002:a05:690e:43d4:b0:662:b56e:64cd with SMTP id 956f58d0204a3-662b5f5938bmr1327767d50.8.1781598938682;
        Tue, 16 Jun 2026 01:35:38 -0700 (PDT)
X-Received: by 2002:a05:690e:43d4:b0:662:b56e:64cd with SMTP id
 956f58d0204a3-662b5f5938bmr1327746d50.8.1781598938240; Tue, 16 Jun 2026
 01:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
 <CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com> <20260613144612.0c5b7ba4@kernel.org>
In-Reply-To: <20260613144612.0c5b7ba4@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Jun 2026 10:35:02 +0200
X-Gm-Features: AVVi8CeQ3jVbf-KzGUfJXXjCbhXarTVvO5RoA44we9duCL1ckJ3ss1l-cBbGECA
Message-ID: <CAJaqyWeGAoH_vy8a7ZPAtCzLMg82rjP0uja8dErXj+gq70FWNw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, xuanzhuo@linux.alibaba.com, mst@redhat.com, 
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299775-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[eperezma@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,redhat.com,lunn.ch,davemloft.net,google.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eperezma@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B624E68D388

On Sat, Jun 13, 2026 at 11:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 10 Jun 2026 10:27:28 +0200 Eugenio Perez Martin wrote:
> > And the From and Signed-off-by emails don't match, which I'm not sure i=
s valid.
>
> It's clearly the same person. Please focus on the code, not trivial
> process issues.
>
> Quoting documentation:
>
>   Reviewer guidance
>   -----------------
>
>   [...]
>
>   Reviewers are highly encouraged to do more in-depth review of submissio=
ns
>   and not focus exclusively on process issues, trivial or subjective
>   matters like code formatting, tags etc.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#=
reviewer-guidance
>

Ack'd, it was just a nitpick since the fixes tag was already needed.
Thanks for the doc pointer, I agree with that so I'll try to avoid
these nits in the future!


