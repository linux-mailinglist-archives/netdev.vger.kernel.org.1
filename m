Return-Path: <netdev+bounces-301866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UiHqNnrDPGo+rggAu9opvQ
	(envelope-from <netdev+bounces-301866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:58:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F96C2DE8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:58:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=mYyDAGyU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301866-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301866-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE9153010C1A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 05:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755DA3BCD26;
	Thu, 25 Jun 2026 05:58:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39CA27F19F
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 05:58:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367096; cv=pass; b=RcOq5xuHGeRwmTOD81jBC6whPxdBWAIIya4OwOZIV/4arMIUA7TvS/xo3YylVwPHtBR0o0yU736GStvno76rYWpSUzLDznueWOLTv/0tcsIFkh74SJH3IeogfmVXMqxe26o1mcwIfaHJJo8NFgwjJmpcpLmc7+R2W1H2WxIgrRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367096; c=relaxed/simple;
	bh=mVt3zU1J16cnDqRXLSa/84eJZZbpBrArAC9NwyHHXTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQY1/YnP2R4hpe3hX8yZbS/f9XjvMV+i/XA+BgUZPhuNdHuMFA5VkJ5MogSddfQkfP26Fx+ZKU8hIvnkQrQfOtH+Dbu4ShOkF20EyKNrkwpEJLyygFTopL3IKyVa8TI28zOloXK/RSDljGMMcT5YUTfyyllKYnuAX1xZCgUxQto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mYyDAGyU; arc=pass smtp.client-ip=209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec450b950dso363100266b.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782367093; cv=none;
        d=google.com; s=arc-20260327;
        b=cR7FUBGW6pawfkV0o6HVcid1K72Erh29Z/QPfYVCbCZ/dFJ199HlxsfMqsDoDA8ZkQ
         37ryjgDfApOVCM1cGe5+W0F8N/+00Cj8wKLOVRLk3rsLCMFJ8SwtwzQXy8W8ZEB2mKdL
         2aOukt0ciwQL+cPJITaacE+pskJg8/K5PALpaKcDwuQu/bCZC6VaSHk8x3GPwgm2y0wl
         fxe3LeU5+8S2A2UdK+P69XOqG7OKid6f52d5WW3GZHZ7ldHwbzT+WcGy9+dYEGbRz01W
         fxMJIUsqB9WMYvHe7VLlGg7gXafXt4c/WfDFmWxawGJvLmpTYQrS4Cr1uqwylcLHCTkF
         6w5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M2BCBSRe33jPlXVAG+sssMb3Q/EImeCCfDRHDxPtL8k=;
        fh=JBCJYmujv41aSBbRTzIGDjE+VMRTtlxlFoTnHM+a6T4=;
        b=Yk0ExaLitqkUliMFJy/KuEmj6j+nkljp4l4KqGPHu4oJjhtGzYjJo5EKhTVNlEKvN0
         yiPKoo9QjonFxb3zgb5/07jZ1/qPoz1AP//D/w/HUyQgX9XGh4zHkIMtGlgSbNbI3ZzB
         7Zuy08ZRz4f5Wjbg86OKslwbdiy/WgLLOKsDl+4UjvZuGxObn+64FwcpVAT8JwQLLm3z
         wlfmMhi/NhgE2mMiaeVeOHCOjzQ8XXGo9tyo/B9nBxamjg9tNcY3AgFHchO2SQx4DqzV
         Y32qiNmGIuYXPoytPyGE9GXA7RRWaFdnCY3ZOvZrk4FkzeQSZ44awpCMudglSylRK5RP
         n0BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782367093; x=1782971893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2BCBSRe33jPlXVAG+sssMb3Q/EImeCCfDRHDxPtL8k=;
        b=mYyDAGyUoWBDhOT2tU4NJLUsagLBmjyGUdptft43G1uMA+3pW8ME6tVlJgPUeBLiT4
         54uXslE7lk9dHNDca2GfSwdWnEjT1KxqWFMg004cSRgL4Q/ST4d9dsza335CtxY9g837
         bDQv+bQsfrIxiwJFQ792n87LuxSlBImO8h88CZDCbZWmyEGIUJWoeXFs++V9ieiKmZUx
         ukJsve/YmCOGu8RSaUtBj8hLwLevgYgWh9p2AsO3rGPIdGvQVG/Hg5BciWwUBls66XQD
         FQJjeWUhu88GqUflizd0xyV23uCYXEJr4iS1FilQUWnG+qzYADzX8tyKKFKKPGnJaIY/
         Zd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782367093; x=1782971893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2BCBSRe33jPlXVAG+sssMb3Q/EImeCCfDRHDxPtL8k=;
        b=PeXZGjo0d/g417+1K02UQpzwHagrc+JUF/R+OeLWUZ8KADtMxq/euw4eZX2DfVLkaF
         YM7nliTiOTcflA+PXoP/QjW/wxMwiQNsBvttwQcGJbLVmym0m5InAyMrzLQ8300iH09Y
         qZN7+PwkReU6GbUh00HQdZxGXHwBBv8N7P54Doxw8L7pxUoVNDhCRSPIqT+zTC0wTXCl
         rZuwTSEUWUMAZJ8p3bZrQu62M9nNWowhVur6EOQ1H4fp0cu12ZOAiv6hJcNSJxM+Iqx5
         mxiSFNu2iBP7z0FpjSzkE3qG26HeTEXQJVj8VeJAGwyU/ds15qRqKOolEhiP76GrQ1J3
         LtXw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7iwUW6Cnk+zT6FRtYrjMJD3/zUBcEfojNVkZLk+nk2+LPtRMuh1wc02yPA4GFn/N3RkzSLWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMhu34T8hhRqXpq7tkbzRDnhdn1N0sJbCGYZPUA5mwYxK+7hf
	srd8vQEh2vBYBG4PUeb0+mha5GOaK2Wbe+e2kAVOhdPc7rV55ru2cD+OFFGEyRMFbpziO2Jw/DW
	pPJu2nPYGnw0vHvOwZ45LIX8P5lnF8u7HoNyWVrws
X-Gm-Gg: AfdE7cn10gQ/TrpGxXPsTXn4rqH0D2IZBEBS31YLmeqzBVraFGT9wsqds3fvX68LhLz
	q3aPdEfo3s2iSW1NC6exY/5g/48aw9IZT0/bEZOZYX8vj3lTsRoXQF6eaXc7t0dVMpW1H/UcHoG
	RViTXgb53iB9QRs6lAQV/aayYoaoX/y5wWnkWLttum1j3TRhcuYHy6bgfnGH7gGqZmcavoBbp+t
	g1X/XnB8au6QjBp4MSnH2n0u/m5axt4xcSZsQQcCse9f8HqV5L59vjEIDHRHN9VKz3geRGHzkYj
	h5PoQkOrGJF1/BCV3Q7L2L+mJgE/nmzQoXojf75xTY/U8+jIYmZWNPqybD5kZPwBD9W24qMXUZb
	QtILVwd0zViVa6J8dmpwf7OkCWH0ctPVjw7SK2GpNfw==
X-Received: by 2002:a17:907:97d1:b0:bec:157:a630 with SMTP id
 a640c23a62f3a-c1205e29350mr47172066b.23.1782367092680; Wed, 24 Jun 2026
 22:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624182018.2445732-1-kuba@kernel.org> <20260624182018.2445732-4-kuba@kernel.org>
In-Reply-To: <20260624182018.2445732-4-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 24 Jun 2026 22:57:58 -0700
X-Gm-Features: AVVi8CeciSzru1N0nNjEjqdO5ry1TmyZ4arTcouS05YeYbgya3JgOVNEWToAnYc
Message-ID: <CAAVpQUCkyTT4XkuY7SHXEWWMLAMe8aK-d_Pkb9MfspE24YRQKg@mail.gmail.com>
Subject: Re: [PATCH net 3/4] vlan: defer real device state propagation to netdev_work
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	sdf@fomichev.me, dongchenchen2@huawei.com, idosch@nvidia.com, 
	n05ec@lzu.edu.cn, yuantan098@gmail.com, nb@tipi-net.de, 
	aleksandr.loktionov@intel.com, dtatulea@nvidia.com, 
	syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com, 
	syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com, 
	syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jv@jvosburgh.net,m:sdf@fomichev.me,m:dongchenchen2@huawei.com,m:idosch@nvidia.com,m:n05ec@lzu.edu.cn,m:yuantan098@gmail.com,m:nb@tipi-net.de,m:aleksandr.loktionov@intel.com,m:dtatulea@nvidia.com,m:syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com,m:syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com,m:syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301866-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,jvosburgh.net,fomichev.me,huawei.com,nvidia.com,lzu.edu.cn,gmail.com,tipi-net.de,intel.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,09da62a8b78959ceb8bb,cb67c392b0b8f0fd0fc1,9bb8bd77f3966641f298];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 311F96C2DE8

On Wed, Jun 24, 2026 at 11:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> vlan_device_event() generates nested UP/DOWN, MTU and feature
> change events. It executes an event for the VLAN device directly
> from the notifier - while the locks of the lower device are held.
>
> This causes deadlocks, for example:
>
>   bond    (3) bond_update_speed_duplex(vlan)
>     |           ^                v
>   vlan    (2) UP(vlan)    (4) vlan_ethtool_get_link_ksettings()
>     |           ^                v
>   dummy   (1) UP(dummy)   (5) __ethtool_get_link_ksettings()
>
> The dummy device is ops locked, vlan creates a nested event (2),
> then bond wants to ask vlan for link state (3). bond uses the
> "I'm already holding the instance lock" flavor of API. But in
> this case the lock held refers to vlan itself. We hit vlan's
> link settings trampoline (4) and call __ethtool_get_link_ksettings()
> which tries to lock dummy. Deadlock. There's no clean way for us
> to tell the vlan_ethtool_get_link_ksettings() that the caller
> is already in lower device's critical section.
>
> Defer the propagation to the per-netdev work facility instead:
> the notifier only schedules netdev_work_sched(vlandev, VLAN_WORK_*),
> and ndo_work (vlan_dev_work) applies the change later. Hopefully
> nobody expects the VLAN state changes to be instantaneous.
>
> If someone does expect the changes to be instantaneous we will
> have to do the same thing Stan did for rx_mode and "strategically"
> place sync calls, to make sure such delayed works are executed
> after we drop the ops lock but before we drop rtnl_lock.
>
> Stan suggests that if we need that down the line we may
> consider reshaping the mechanism into "async notifications".
> AFAICT only vlan does this sort of netdev open chaining,
> so as a first try I think that sticking the complexity into
> the vlan code makes sense.
>
> One corner case is that we need to cancel the event if user
> explicitly changes the state before work could run. Consider
> the following operations with vlan0 on top of dummy0:
>
>   ip link set dev dummy0 up    # queues work to up vlan0
>   ip link set dev vlan0 down   # user explicitly downs the vlan
>   ndo_work                     # acts on the stale event
>
> Reported-by: syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com
> Reported-by: syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com
> Reported-by: syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com
> Fixes: 9f275c2e9020 ("net: ethtool: make sure __ethtool_get_link_ksetting=
s() is ops-locked")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !

