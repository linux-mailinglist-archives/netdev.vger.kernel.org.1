Return-Path: <netdev+bounces-295718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OCQNBLGGImraZgEAu9opvQ
	(envelope-from <netdev+bounces-295718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:20:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A7646569
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:20:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=CNEe9PUp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295718-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295718-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F1A301E5BC
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5549553A;
	Fri,  5 Jun 2026 08:12:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957E3FE641
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 08:12:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647178; cv=pass; b=W8QrdjaAG/LMqhIjHuKMBJlRblXWXQTlD3sgMPOE6xx2tqG2IdYB3tCK4RSH6d3IyZDF0ddPw7GjvVogm4zGt7IouMN05D7hMdOH+rSC4FiHd+SIufn/o/QcyVjHzcC+InZjZR4t7Z6GUT7iiBfNJE+/IXD2wWsO8C6AVWgkYAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647178; c=relaxed/simple;
	bh=u8Q1WXjqlC5qiRxn7sucCO95sEC38cQ31d6p2EtwTxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/QmU5UnIYtRz+BHKtRLfciWpCO8k2omvMYsdoNA/cyxSMeeavPEuPfHj2vO9WAFfW07gByENQiHjgMmPJzTBflGGzT0Gf3qTpZwBEBw3gheQLlOTFRV3GOSGjXMvu7FI+yNP76AihYWopJ4ro/XCibyKjExgtwomCeVr9l0HLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CNEe9PUp; arc=pass smtp.client-ip=209.85.167.42
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so1699109e87.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 01:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647175; cv=none;
        d=google.com; s=arc-20240605;
        b=EBHlRfVuHQoq/6jvTDScvwF2vSv87u/Q3wDQb8X54xNz0x7xlLtz9RnsJ39LfefCQw
         lwuYCYAsELUgHgD40pQQl+ZOB+kXMlHu/Z0rThec2aP3c33JhryqXqz3NcE/FEEkxAab
         SYpx/sED7WrEU/VIovWHCAub0kcsaO+BuhS+yvHZfFLiXNXkPWuTxy6OW/qku/UO57WG
         sQTlVFO5NRT/LTN+L7s6pRnh5+RFdAfrziU58VWljftp6eQqvW/PCQS2d9LcI8pgL1Dg
         lyFYb1oqJGqcHOThCz7wbHudpj4LRYbK4xdYrtT1Vx5HyU2pcA6M5C6aVGFshwgnw40F
         PpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UNQ7O5z6I1BYhENIlkkD1dwN4YbzeYUuGuJtBadnfug=;
        fh=BT3Ebbie907+LLtyxaYHmvXKjOQJkhBamjiUk177siw=;
        b=NNV0RfKoPCxwGQbM3ckbL9DkaAl52h313+nPD/Tkh2sUzzhB/NOXUayPtYHhTKnZ4r
         +z6dneOWxJD+ENl8J9aqCtPXgIH1hVurO4rGIF+b4BcYSGL53hr89HYHCLcta9LBrGih
         fVQRwnIGdVRNjIIMhIBy+p9xlUOh6HqL6AGOmfLNr7EhCbLYnn6nwkS1uJgSsPv9XTAb
         POTODyb4ASmha2afDg0hJyh9QOmYUyN6q0Lvc73o5WsaQpXLBS2PMjXwX/MdP7A9OfWK
         wJzH5Vn4vK0ks4gGey1Bj3URlEk2tkzQcSqJu2kEOXBwkGwbdhBNghGa1uMq4Dzcx5rE
         +A0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780647175; x=1781251975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNQ7O5z6I1BYhENIlkkD1dwN4YbzeYUuGuJtBadnfug=;
        b=CNEe9PUpaoijwqkTIYHI94153VfVRW8M3uhHS6H1dJkNBlDd7+ha4P7nkNjD6icidz
         VGWq+BtdPAwtJxmxWIsJtsogm9MPVtD3m+pZgUkunYEUszSJOQ1HBTNB7BsTEOCG1pno
         CYd0z9BIBMWMp6ma8Ec8Xx7ru4m7bFcvtT3kDJdStgoQx4UzkA4A3ZMqSB9UwIGbM/nX
         GeM8p/P5y/Pi4Uz4TGNaMEyuOK6JxtUEUojuPh6tNHvFttcf7xwAT9aZFdx/h5RWUF5+
         MGfwfxdXxNEnky5E/hL2oameukx7OtMpy/U1U511qJPuQ6dGqxMjvEOM1HY7aHC9CiKU
         nsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647175; x=1781251975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNQ7O5z6I1BYhENIlkkD1dwN4YbzeYUuGuJtBadnfug=;
        b=Swa00MUmz4lyEHDFzs5j7Bd53Ns5Tq8qo06xLA1qmDSyAI99LNSdOe787pqDZ9kwqx
         ExGlYwAglS9beuEa/Gec3PbEfdgjsyyxnDl8hEm+9IxMEajN61sRS3UcBYD6noDQ5eGz
         zQAGbIw2D6ge1aRhUHmNL/PXCQkRjgHz9L+jnv3iaBHqCQ8KHrl7eNMjLtFJ5L2Uc3J3
         uhchPKtoY1ED6peglYQNmBNrZSHuAD0R98WRAeaZJB5dqfzwG2P2q7cldgcpQo4BBr/S
         mUkWS6Voi2PcoNa3pL08kh3MpUyqYctX7XTRUU0T1p+V8AcsSOOy2oBcUHArR7cWprf/
         IBIg==
X-Forwarded-Encrypted: i=1; AFNElJ9nfBj1cf4Gawol8e0o3lpsrJiGPlocwQgdgyPSQpWnTOMVkjK2siIQVoT6Tb4x6gvmmRhi/bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkK/hc8uBq9bTdeRdLtE1cgFKGjzp/Yy4PLJtp8WTQ4zKAA6bM
	HwX8kjiph90MSEyj0wdZKc2lXrX4dXSlklzBHsANxP8ULHSSrC+kLJhqEfIe2aMS/E/TgqTALr0
	5DKaNUVKtqLJRA+X+7GiN3+y9XSlt5PX7CLIDMjPf1g==
X-Gm-Gg: Acq92OGXharxIgp7CTYKCBC10LgBiHDx2TLEnGaQqg0C5U50pDqo8IyLXdUyILyv4pj
	gF30N4c7XRSB+HWxTD8XtlUB1xmR+donalMkfl/fQzTx+20VnHIV+qNZRerQznCzHwK641gXbkH
	qQSNxzQigCvwA27lHHxU9vIooEFt+aMvaLITCkXafCEVeoCOyb+LEXJ99w9H9lCahr8SepQR8N4
	WyE4+XTBxcoL6eZbASxLYH5gggMztRz8OOab0/25YBwisUwWXwQi5G+BQYPSFbDaAiwA8hgFXCG
	KGE/3K36gixf5n28PB/ybyXbq4bx6v3XNvEWIqmoCNMoUFDznHA=
X-Received: by 2002:ac2:5098:0:b0:5aa:2a75:e14b with SMTP id
 2adb3069b0e04-5aa87bc23e7mr500538e87.18.1780647175361; Fri, 05 Jun 2026
 01:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507130117.252825-1-marco.crivellari@suse.com>
In-Reply-To: <20260507130117.252825-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Jun 2026 10:12:43 +0200
X-Gm-Features: AVHnY4IBbk-mtCcmYv-f3PQjt98lbgBbhfgbnsFIyJNcIJ7haAnpnTNZKfnc6Yo
Message-ID: <CAAofZF5_MRtySWTMs-J3T676FwjJiLDpYLRWmsFaSXePo3nZPg@mail.gmail.com>
Subject: Re: [PATCH v2] xprtrdma: Move long delayed work on system_dfl_long_wq
To: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:mhocko@suse.com,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295718-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:dkim,suse.com:from_mime,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F7A7646569

Hi,

On Thu, May 7, 2026 at 3:01=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>  net/sunrpc/xprtrdma/transport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

SUSE Labs

