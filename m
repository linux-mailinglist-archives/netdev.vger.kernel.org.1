Return-Path: <netdev+bounces-253224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMbpBuiPdmksSAEAu9opvQ
	(envelope-from <netdev+bounces-253224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:49:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F51982913
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3E103000FCA
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051DC2F3630;
	Sun, 25 Jan 2026 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i366CjZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835842F3620
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377765; cv=pass; b=QthfKmz/i5X/RVPNipdSlvE9jQqmkvpBvdEPyNvgzTCr9AkYcVXDIBTflNzgzeZRE0GspcBo8Nem0nOfkiNKNd0EXubugdZ7ttIBxYDNTtlYi+Jn7vmWWVcVluuwvMSgw62rUEo4BwqxEsRY+iKKGLvRnuc6DecZn7UV48pGyaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377765; c=relaxed/simple;
	bh=135DjDvKEI2uc25eqDc52rP4JGlGEXtVoqSTMRLtmXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPyQA1QZj8q+oAdjosYXdT9rszGSXx0/D9Sc1ihwRMkrCFAKTq6g6EDaNsXfcoAgk8RrumW40w6+4gDWeGj92ENfjF4OR/Sz15LXnleE+YiopvUhiWiDVtIYm+uZ7px1Dgr+2uc+wxlFFCBvl4emxtzewLTQsTcq5qjwNbQyeHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i366CjZu; arc=pass smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c6a0702b86so408328685a.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 13:49:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769377763; cv=none;
        d=google.com; s=arc-20240605;
        b=MuO8EonY+AdIznK5kiNCnieyzM8SsArNJSSwCzfbDdqsWJlE0PdzC+rwCui8M82Yak
         20S/g4U8cPV3iMUGKNAedJ5hNFxz1HtSyFMrfszRTD63qABP/fKcXAQS+T3v/sPrfbUZ
         95VsBkfj8ICiCuam8NGpAsS3uxc8Hs6tvScFOylkRg5hgfHHLggIFzR0vNaUPAEztTw6
         slHRhEoVXRce+13waHa6ZkNDlY3aW9a+sEVG6lxpwpnwHARaYbQkAhap5T/DqSYjsvcp
         Il7u4Um4N5JyKxNLd5dCONryDcK3Zno4LRl0pzC3b7c46c6T1W5qAW3oyvshD1mpB1iw
         X7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yv/cme5pZKdjbm0hQuQgxHCXXEw9AsXBiyyA2aU7fPc=;
        fh=6KLcoqYUW+MVZshfLsR8QoJF7jC7ki9qFS6wyxOqfz4=;
        b=F7tPg5vWhD6k3Jwwc8pTYtDUhUqY2BsEkiZO7TSQfL45pElepqX2t3rvDlv9oExxPl
         PmdCsKbgN1as7MP6iSXvjFXlAYxf7ccgABxyK2m3H9wQdyJo25P7vkobBhTeGvV6op3o
         nk5mVIgrmg9MQOls7ctz6Mt2W3mp+Q4kFWEUEqSwGAQYw3BV7n0EwCRm32lY+WTtn1v7
         eJwtsU/6F+b9BUgN85ex0eOOrDgSxnzu6ynqXEXQGYuRCHEXu6hvikjvAxxiPnphH/p4
         67jZJlR7Hvmg2dvO82DcAq0S4gkgzosG0cgZc4xxbRuGQRnqmJhXbsek9WJCYEIWtCs2
         FHzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769377763; x=1769982563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv/cme5pZKdjbm0hQuQgxHCXXEw9AsXBiyyA2aU7fPc=;
        b=i366CjZu4rBHDpZwjgq6r9w1zyFTgjyvAiTHFpFpAlREhijBPu4ZK1J1mckv2vgdpl
         8CKRjtWUILChN2sJj8i54H9DQ9PHiXEAU+2B10BYSpGPybm7aqPI5fM68MOw1bksHkW2
         ZALSiXt6oxJwMoDcqrt8FcQ2yUS0xJp0w/7eqbtnj7VVyWWW2fmdA7dkIFn79y4LE+s9
         0IcEUNzdLFVtm6OzcW/iRBSW/FrzNeFssclGTdctuS0KAohy7S4lWE4fwruhIhyn8GZo
         AJWDrVCCtd0Fb2xrJ9iNRdSwb5ZFxhSOsRXlS8Biimc49ADxInP73MA9a8WNjtyX7IlC
         EcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769377763; x=1769982563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yv/cme5pZKdjbm0hQuQgxHCXXEw9AsXBiyyA2aU7fPc=;
        b=oaZiEM4YIXaVGkm085lHKPCwq0GqdNvu9/BrDqAgqL1uD5tH+9ruvXG40wymcpbixk
         92cE3tqEV6l0Ui/u7zYu1VhJVyIOiD5iqtLMLddZkcz3NwXgeBbul1bmxuQy5PKlLZ+J
         KYtUU+WvFge7ZAcIQUmJ7hEYhqXoK8cLDS0XVRWB0qf02BwRunTwJtz8kgBFxBsgnkCg
         PV/QBKkpgAsjUwQMnuTMx37RksrVQvdfC10s9o3UYUx6Ab0GRwWXYr9uJS+Ay4RIMewT
         2bh0VKH8Uh7ET/m8eg0d6Fou1X23/y8dQVWW7ghHenpJmO8o+Qf6PasKgE0+q2JgkJ1m
         mXuw==
X-Gm-Message-State: AOJu0YzSdjNOkYpHj5qCz+jZrwsDz8O1drFX1ImW1w6PI7FDjewwFqz/
	Ud+HaHfisZTVVnfk7l2Oc/33eeokX94sRU6ezNxMRWsLA0o0MFJilHELYOvlE165USAtwmngmZN
	ex5mF2KcJPJp8EUrhbV4SkU2LcOwa/NA=
X-Gm-Gg: AZuq6aLOe4uqUfRqGbD36pliF8HL0bSfkAscdsV38Xj0jPyJynwV0v0WTqYcyQI70b0
	lOHykW0Glbp4g4VM1D0p6vSiHduaNmlXTvdMfxnY/2Sva1mDzkmaCd+TBkjEjCI6sXsA/Tzsc7z
	muVYrAs4hoVOSbdf6c9LSE7VAEN1Y5tcbi1EqbSDv9ixwFDlEPu88BDP4waiXiRTZHQHBjLoqRh
	qEuUNJaxjU2KbuB4nKQo+hsPKnqWwDUctUCHquXCUWFREmym+Zg0scqsC3hcGLaBSMPhDPFu7BA
	3eTzdssm+ojYH4HieFmMA9uxoaWIrVDboVxx0Z2P6cGwFgcrJ/Z/9jAzwe3o
X-Received: by 2002:a05:620a:1907:b0:8c6:ed3d:be60 with SMTP id
 af79cd13be357-8c6f9677d07mr305926085a.71.1769377763352; Sun, 25 Jan 2026
 13:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125083501.34513-1-enelsonmoore@gmail.com>
 <20260125083501.34513-2-enelsonmoore@gmail.com> <dd46b4ed-f0bb-4b69-938a-90237761673d@lunn.ch>
In-Reply-To: <dd46b4ed-f0bb-4b69-938a-90237761673d@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 25 Jan 2026 13:49:12 -0800
X-Gm-Features: AZwV_QgN4pJpeNPpAJMIQ3LTcWEwCKbAmO00Ol4_bURVivKxKOSShXCP5azpLFc
Message-ID: <CADkSEUgjx9=tGMuoXUUNb_bnM8Qnk=xV+ydOx=AYNxSrHFm=aQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: usb: rtl8150: remove rtl8150_t typedef
 for struct rtl8150
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	Petko Manolov <petkan@nucleusys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253224-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 9F51982913
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 8:40=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>   Netdev discourages patches which perform simple clean-ups, which are
>   not in the context of other work.
[...]
> These patches are getting into this territory. If you have these
> devices in your hand, and are going to add new features, when we might
> accept them as part of a bigger patchsets. Otherwise we are likely to
> reject them, they are just pointless churn.
Okay. I won't send patches like this in the future unless I am making
major changes to the code. (This is true of sr9700, which I will
continue to improve - I am working on documenting the registers and
planning to add support for missing features that the hardware
supports.)

