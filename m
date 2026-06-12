Return-Path: <netdev+bounces-298481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0V8iLS+vK2pXBwQAu9opvQ
	(envelope-from <netdev+bounces-298481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:03:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC167715B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:03:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=K0i1TrGh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298481-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298481-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E6743051AB6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BCE3D903E;
	Fri, 12 Jun 2026 07:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5923D648A
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:01:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247706; cv=pass; b=b1CJFog5JA9IV11THYHeETcJ5CZtUErlhsCN1ARbzhcTdUNALLwYAunpRuUf7jOnlykZAR744ucPJ97/pgV+YOehEaUVFE9+ZYvLNa4okgJhgm7bthvlslx47xhT9IbnKLGTRJxN9DKXJHuhEwMocSLES08AZW8vTdHcjX+J39s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247706; c=relaxed/simple;
	bh=InPp7ej1yT86/ndkgDy4dMtSxeVN9Mc7Zh61V64SEC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R92tRaUSK78OZzlSf69fxzlTTn0dKSHUhxFGtgnE1EX0KgmbXNFa6Utb0VMaBy1SScmzMjOGmmkZGyMiK/AkW+0vnROSUwNkPF6GhZkFF8JpAzsw+7mZbRKxILb6UeBJ4dlg5Xn+sSQhkcvLvdymBo93tKzPCuoQ1ot1QgaHpUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K0i1TrGh; arc=pass smtp.client-ip=74.125.82.43
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137ec563a95so647352c88.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247705; cv=none;
        d=google.com; s=arc-20240605;
        b=HMkCTN09RI7/O7o+MsguhER32XyR35d2qwhaB+loFVfOwHs9NAi3azvJf0TK1IzQvE
         OdrcvS6GD9NnNqJpwcEZti2xwLBEqS94M97Upczte2g2d9JhzZzDVDl8Ghq+yM8iK6g3
         WuZ9cdnMmWsjkr1afMkeL6ApmVGRfkYmoeGddkgUKGvgfGQr3X8ce9oSXdKh95ibcoiy
         8OSj3CGs33fDMIp7FeduxBizFlVy36Uh7uxQR/t2J6irQIDtvBJLckxV4TxeiLiUd0GG
         CkBHUr9QbQKT8yEnkjIQ0QphzpWkLs0Jw1YywvzYVU3/MtdDumET/OoXVjx+cMemITBi
         vSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=InPp7ej1yT86/ndkgDy4dMtSxeVN9Mc7Zh61V64SEC0=;
        fh=nONsuWR6EulYqNcjISfqxtNLr7yiYnKj7e22XVkt1sA=;
        b=H7e81ADz04HkcEd2+o1cbEEEDPduyepZ3l+/IJElFl5GBrDocjJrA9N3y0v3CygCX8
         EhzsJ/q6xRdbP51WhjDC13uN1XT1YPU7rIjcP/qey51p9KaMg2i5pGp0cq4VB30k9vDg
         msVOmenXAy30K51g7DMRjKvbNevTKxgHxZsdyopBzayv5ptYhdwy3IIBillw8VRVPCPN
         E2z0CaLYDdQU/kUHI/1yzYw/RbAl8p50jfv+nCkUOcMO63geIi+mnLvBMvv+nJ/lWdJq
         +kVsJRrrqKO997LUhTkL2OUhyfGkW6FkYUakNMjZrybjMrm/fOmB3HaRkBIKCq2nQ2iW
         bzwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247705; x=1781852505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InPp7ej1yT86/ndkgDy4dMtSxeVN9Mc7Zh61V64SEC0=;
        b=K0i1TrGhc3E/DC3IMW+dsFoOI1kDwKxaen7QDWBXYfoXv5bWy6Ou9+3PaZC2+GnwkO
         oiCTVuDjHxOL3caEpuHu3PoiAhnlEcxeSnOO+Z15GUNEtqcWBwD7PNHtMb8GLzOCRT0o
         Pqn6d74bM1wVNqUfM8DjV8GBHZ81njJY6nXv5aOMSLWJVXRp9ko02r5WqsJCyWW/6BQU
         S+yu/VPA1MqmgKKqwsvCY6zzT9Qlay5CmF6+k6wUHU51RU2p6tqPCv4nS/TOs3PqxooZ
         CaeEHNjKw88o79jDR2qEmibilY1d1qHqGHdabZi8SwK6etR2HqYv69JimyjRgyvx/aux
         I1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247705; x=1781852505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=InPp7ej1yT86/ndkgDy4dMtSxeVN9Mc7Zh61V64SEC0=;
        b=cVYqaaUbHhxs62Sw/Y0VlXPbcJBloI44nKvCrwGGxoZ/GhnYa6frRJm6iTjyy4L8AP
         LnM2dJmmqsQKFuVSOyxMraaf5J0azzOzDZ1v2hdhNqIDt1AZyBEVQGaJr7fUFyYYt3mT
         sT3+ZbPt5H3lneMaFlaUQQ5FTbUnrrvVC9PlUOMpXgdsUWKxqMt8zZtVay1EmG1jr72n
         /XpNSNud06eO9E+hAGtlm1rE9HhmGouVC5VmGt+c8y3T+nH+V1A1CgM0Sd3tyL7BV8cE
         zVE+1WYVjdrxhmQcM0G4yEZ6X5LwgDVCVKCMz5h9UAOfLh8zXhWborBuuSR3+NwX6uZI
         3PrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4ggzhLh7q7kT4a82snoyeRtYBq+BmSKnIqD/dH0sRa7N0St5/yudGfyK6pctIYo2MSYyCriM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvu/KS0VxsU10elgvQjKEkkRIkFPs5c2xULoMTqZWlgmqZdcpz
	MXvZYolkzBgCG7xG5rHc2JbxkFvNP8qVshbN/vtJMXqt0yYD2Yt2hrYZAl9AqUldADNRIuzuA4w
	WtjhMFL9I+BFi3gHgAhQMXxbVxUdgQpi3FjFdr3MJ
X-Gm-Gg: Acq92OELO9ZOrn3S4ndVXiJHH/CLLLQSANvuruY6Vj0/wp2aN6elrJ6ARAG4wOliI/w
	avwqEOx1noXfHObVilKHD0+LER963CCMkWaGJy1LzT5yCJYYfNe547Wvvm6xk2eXaIMfg8UBLtY
	VR/NiulM1wAX72FMAQHdPF8eERDQM0r+7qmJmIz0Tu38BxvvTBalVvv7g084rlGDZxfz2Ps8pqb
	6BX2DVDHs06iOjwXuDdjs0kmVgB1/m33TwaVneJjRbime0nsh52UTXaGT9LhZkwl8SVo7LmZpp9
	uh96v8XNsLY5QcEsrwfANWpNKW7J6zrkWpi54YJ3EwhloX8FJgiGwe42xkvLE3HrGhtrap9p0s5
	7toP27MQZSAS89TtCP82f27lFFB6apl9CoVKcjRuPAOt5sdyrCm+V
X-Received: by 2002:a05:7022:692:b0:138:243e:ceb1 with SMTP id
 a92af1059eb24-1384bb1abb4mr811348c88.6.1781247703664; Fri, 12 Jun 2026
 00:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-8-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-8-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 00:01:32 -0700
X-Gm-Features: AVVi8CdNFhjQWdclCUPGXyrImRDlOr2v8TiKlXZvLYYwjbgiFpqUyAQrvSMElHg
Message-ID: <CAAVpQUDz+gkVpsYZzQrW2kwgc9csh9=V+DBy_nkh6YnfRk7Zgg@mail.gmail.com>
Subject: Re: [PATCH net v5 7/7] xfrm: xfrm_interface: require CAP_NET_ADMIN in
 the device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-298481-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DCC167715B

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> xfrmi_changelink() operates on at most two netns, dev_net(dev) and the
> interface link netns xi->net. They differ once the device is created in
> or moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in xi->net can rewrite an interface that
> lives in xi->net.
>
> Gate xfrmi_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

