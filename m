Return-Path: <netdev+bounces-258080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CVvMp8ni2m6QQAAu9opvQ
	(envelope-from <netdev+bounces-258080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:42:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 434A111AED3
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 929B030333F8
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE731CEADB;
	Tue, 10 Feb 2026 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q/lWE9Nz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E01C3C08
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727324; cv=none; b=mMWrnI4pZX2DcUrBcNGpWZ+PTEgdxSmxIqI2uaaY8CS1LalNOXOvCSxN136hjiwSHdGD7Wp9K9Y9GjVtXB939YqmjVlfONJl9BkIg32rRi6L5F4OE49KOvR8/+9alxvnayqdQHseGkXrwBighRo7XfAr/dK7+l96F+a1QrD7nrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727324; c=relaxed/simple;
	bh=SbluVfimyy84s/QtJg/T2Bs0Z/knB8D07nouL0JvIec=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=N1Mu6yDiA432rdh2F6w1cdb5HCbm+FJLxjb1xhBs+9MAkOwIGk2u7ep0gTBiOhIQkasQERtHOdtmw95czMKsAJM4DZurUStoEcKQla2wCifF3rfzA9cM+/MToCEzaiTc4xdU+yKBqNsKF3o1M5HdvlToEMS8xgg7Ew+3Sqne2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q/lWE9Nz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so18642715e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 04:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770727321; x=1771332121; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUJ96o4kL4T02J8yjr3fBu3LppZT4kDSzMI7O3QGA1Y=;
        b=Q/lWE9NzXAhz+gixb3BhyPIvyA9iRY9RuDM+bgSnUECEr4p6tETXs652gCLTMXMGvB
         lr5aaJRRWKF1O0pNXd2iAns6WDqPc5f+hwMKROSn3AMSPGbzMk9do7opO44E9PMNjHcU
         x5ckSoBEGO5KR7l4k1BPbVIag/YLwB86hoUjRQ13cltJgfwwbMWutJ73WYq6Dq2nJV+m
         NaDRUPHCOKwlq1XTPMLfrEs88okIcK7i8iG9Wa0pMbaAZQQWKBlRzLySuKYKMRQcaBOi
         eMb0tzn6w6pX9bMB3iR1NLD6osgh2w7655s679LgRGpODhNJTU+3dmcBqYdJDK1dlC53
         mI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770727322; x=1771332122;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUJ96o4kL4T02J8yjr3fBu3LppZT4kDSzMI7O3QGA1Y=;
        b=tSeVW7AG/MUGgU5zwPZfxQgMgDjuq+rTX+LLkAB7IAaAP+v117YC2V7ORS9gWx2V95
         lMJ6QsPtvdCw6Qd8x30NAQWTQlLF5iEgOhhNUra7rCeX0Fg8RiV6Quodj/saBPrOyl4T
         1IAmvp2I5FqxGbpaJxnopEJnWQ8vfF9DCZAaq1n+ozchVSBlvRD3NUhePzdhzmHyIyuW
         74zkj1IstgZmZaIOGPYKrTK3ZIqcGcaq6WJxJRiqsTasBBwWw6OFOjkNzkh9QRu2J5mi
         ppm/q4l7OYio8QFzleOYPGyyO1G8GgCRtL2Gl524arCopaLrK+YsWk8vIfWusOwtPz9x
         72/g==
X-Forwarded-Encrypted: i=1; AJvYcCXmw5qGVi4hGfgeOU8aJRdl5IQu8YkOP5oONfXhOrjl64lG8Uq0WAFsTuc4isSXcWx+W2ezIj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqlCHdRFOPwVGBN0eiHup757MbU22ZI2Cd8sgAjuiVheh7tijM
	CMzDS65a9018IZmpWJMrhd3aVVLMcIZoFL3MdXwk12z2XDmgiwUNvtZuIRVZMLhIdMQ=
X-Gm-Gg: AZuq6aI0lpshgliB0Is3lsT3qtocZaZqTZL2MXHyk/ZGG0npL+yucjdTO7kynl2cR9B
	aGcjQS9HVmtH5Sd0g38LIW1+EcPThrzZvmRoXEEMiijsQB6TKmfb27gQuEh27YaAxnwKlzJRGLU
	c2cxp0CN1/lyKSbPigHP34EBhG/5bqR4Q6feb4Xz061J8UQJsXU+FUSlnrPiCQoL5tjAm/XsWTc
	ZixUj0JlNezlCdGWroAWUBzTNgLH3/yKJBuMwwsfdfQbT/pYW9uxHF2219W4hF5kaceT0G75iaN
	hZTsJeAQkPHH81cpX4zBz4MgW6iNoAs5RgKFq/dqvyNzGvnSsU8hMD73KL+msQX62GbCP9E/ldg
	wv58ynE1QWmqP6JN1Un2jqLD9InD9Xr+3UK2+sBvQS+OaIPWDZeT5IwsMXVdRNiPOXaR0PtAMAR
	Mtb7toedAnulU=
X-Received: by 2002:a05:600c:6592:b0:47e:e7e5:ff32 with SMTP id 5b1f17b1804b1-483209c6dd4mr228549015e9.34.1770727321547;
        Tue, 10 Feb 2026 04:42:01 -0800 (PST)
Received: from localhost ([179.228.217.110])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796528ef241sm35871207b3.27.2026.02.10.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 09:41:58 -0300
Message-Id: <DGBAG46Q9YLJ.PX4A4EM1U4DF@suse.com>
Subject: Re: [PATCH net] ip6_tunnel: use skb_vlan_inet_prepare() in
 __ip6_tnl_rcv()
Cc: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
 <kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com>
To: "Eric Dumazet" <edumazet@google.com>, "Hirokazu MORIKAWA"
 <morikw2@gmail.com>, "Fernando Fernandez Mancera" <fmancera@suse.de>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0
References: <CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com> <CANn89iJxmiqryxLAXiV9z4uTaCzR7XZns32MGSLOykC2zocW_Q@mail.gmail.com>
In-Reply-To: <CANn89iJxmiqryxLAXiV9z4uTaCzR7XZns32MGSLOykC2zocW_Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258080-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,suse.de];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 434A111AED3
X-Rspamd-Action: no action

On Fri Jan 30, 2026 at 9:00 AM -03, Eric Dumazet wrote:
> On Fri, Jan 30, 2026 at 5:15=E2=80=AFAM Hirokazu MORIKAWA <morikw2@gmail.=
com> wrote:
>>
>> [REGRESSION] ip6_tunnel: IPv4 traffic broken in MAP-E/DS-Lite since
>> commit df5ffde96693
>>
>> Hi,
>> I am reporting a regression in the IPv6 tunneling stack (MAP-E and
>> DS-Lite) introduced in kernel 6.12.67.
>>
>> [Description] After upgrading the kernel from 6.12.66 to 6.12.67 in
>> the OpenWrt snapshot, IPv4 packets can no longer be sent to the
>> external network via MAP-E or DS-Lite interfaces.
>> [Environment]
>> * Hardware: FriendlyElec NanoPi R6C
>> * OS: OpenWrt snapshot
>> * Kernel version: 6.12.67 (Broken), 6.12.66 (Working)
>> * Protocol: MAP-E and DS-Lite
>> [Culprit] By bisecting/reverting individual commits, I have identified
>> that the following commit is responsible for this issue:
>> "ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()" (Link to
>> the patch: https://lore.kernel.org/netdev/20260107163109.4188620-1-eduma=
zet@google.com/)
>> Reverting this specific commit on top of kernel 6.12.67 restores
>> normal connectivity for both MAP-E and DS-Lite.
>> [Steps to reproduce]
>> 1. Set up a MAP-E or DS-Lite connection on kernel 6.12.67.
>> 2. Attempt to send IPv4 traffic (e.g., ping 8.8.8.8).
>> 3. The packets fail to reach the destination.
>
> Thanks for the report.
>
> Can you provide detailed instructions ?
>
> Apparently none of our selftests caught the issue, it would be great to a=
dd one.

Perhaps l2_tos_ttl_inherit.sh [1]? I've seen a timeout in this test that
went away after testing commit 9990ddf47d41 ("net: tunnel: make
skb_vlan_inet_prepare() return drop reasons") like mentioned here:

https://lore.kernel.org/netdev/DGAR3PO1D33S.1TI7W7U4SPTOG@suse.com/

It seems that that commit 81c734dae203 ("ip6_tunnel: use
skb_vlan_inet_prepare() in __ip6_tnl_rcv()") uses the new
skb_vlan_inet_prepare added in v6.13, which broke 6.12.

[1]: `# =E2=94=82    gre =E2=94=82     6 =E2=94=82     4 =E2=94=82 inherit =
0x4c =E2=94=82   inherit 90 =E2=94=82 false =E2=94=82 `..<hangs>

>
> I have no idea what MAP-E or DS-Lite are.


