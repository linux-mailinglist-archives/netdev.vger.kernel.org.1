Return-Path: <netdev+bounces-297669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PQp4M35gKWrkVwMAu9opvQ
	(envelope-from <netdev+bounces-297669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:02:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 631056698C0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:02:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qrOilq1V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297669-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297669-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C994E3181F05
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF633FD96F;
	Wed, 10 Jun 2026 12:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391C331EB6
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:50:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095838; cv=pass; b=NeXCld/JNvPs2E2OEgN7aHzJ+EXLlWdjdBFZOpb6oxat+O0atczxfA4mKeEC2oTREpSbSqps3SM9qUz/F1HLJldbbNGV3fgj2ZNZbUNg90Fsgcc5QN+/kLpR2TDVO6hF2TOIzPNZDlpxzrRvWK0Eiroqknx7WKQHcm4+zwo1sA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095838; c=relaxed/simple;
	bh=KMZ0qHYoMeqgFL/9rGDEJU4l6wW6bRfRU6FOp1yHLAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2N5zPz+1JVtv8V2XOJGs5QmGtdPZAVvuN8RIIYUeos2gaE1zSqC8w2iQALOrloA44odSdPjM/oYlIyWWYKEfvVCDetfvMDxcZfTy+31+lDxts3BnMHJ31xXNt4VZlqhd3dy+sdngLCgmyrOW+qJq1j80B1uIhR2Ff78aXbhCAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrOilq1V; arc=pass smtp.client-ip=209.85.128.171
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e2fd65f968so62129097b3.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781095836; cv=none;
        d=google.com; s=arc-20240605;
        b=Hc7D9e1Nn1031nJ6CyeSNQwT+XDyskEsjke4r4W1V0Hfz0CDRd8lToqCQUTZ+B580L
         /knRU7CR4KXeqXRR5bgsC+2+geHD1Mv0lJ8MRM4eRpNNBvRfzF3L9DU5wIBXJp8rD1xw
         GMWxX00U51ltrkIe67NdkYi2DJ9cJ1sB5u0zeVWGZLLeIHousEdvyz6XAGdTu4RxxeC1
         MxG90cguiGyWJ4nuyTzouiGE2uYDrpCNVfVmHc/8lPl6SPWhMJMAjq83I3lodfomS3rN
         BFb5w3kulsHIlgs6OkRUiWbgD+MpZFGqPK9Ii3FnZCIVljJ6LmRSnjSWq4RrtA+wwSrx
         uOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f1Q909GkLQDpMQV4lcc3Ex7t8vmDGbCn0szggVFE64o=;
        fh=+pda8J+h1PgeHQJK49hpXUOStmzkctGwqBgEKT0VNQs=;
        b=QfcyR90TX9J2r4/2Mm5dziLpaAcX3fLwV83dJsreerB7i8z5g0ZRdDSpoHSHA2vDIX
         1sNfockg/5mpwrQ8itkHnzQc9EOV8QUJKyAMqZygqo+QI80QwFgYEHHoPXgaY52Zw+21
         1rqQW6pS2/UrwzAGMXb96f+Izp/IpjbcIo1oJvG8+LsA6GuVkisJMjxyd/PZiovzb/cG
         Ji4SQpzEIbmw6j30zHfDcWTkRAirHdufM0pEUxH9fNQV+LFjsn5U3HoNjqV11J5io2jk
         vq6IAScWI827SK6D4c0/rPeoJFxuzgiulC7uAPt8uWlUJZNcGRwEC/x/MuTYFu9HsznE
         GmLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095836; x=1781700636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1Q909GkLQDpMQV4lcc3Ex7t8vmDGbCn0szggVFE64o=;
        b=qrOilq1Vj/O+pAgS9iFjHbx/R12Z5hW2KuNIM9tS+HP+tL2PW8FnULz24lFfxkzE+/
         Oao9LFDGu0f/YQVw296frHLI5F3PvD7lnRUfgzPhcsX5Gpk76J92/ws1/Hhec1SiMx9l
         ZmBTQOjG804SLL5GETWTD1xrMxbyyl/bSeENOMcxkRBVBv9osN992Dl7roQszCNetEQC
         pYzIvalmc0N9MQoXleMqvTh1PzZEKUBzZCfqIixeA6fQIH7Cn+OSkBUtYfjyFRgTcI+K
         QiJCiWHDLkG6dC88z2M285VWTUypnYtt66alECar14bTtOpQq755nRb4e7IVeQWI/vRD
         0/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095836; x=1781700636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1Q909GkLQDpMQV4lcc3Ex7t8vmDGbCn0szggVFE64o=;
        b=AToSC5AxyGPOZmPiIbIuIqPYkU5iVWO2TJ2yptVNbBvDRc2UpbvudKZjAA/naiZuLM
         lpOIDP7RMkFIZiHnQiLFcIGNmfE3Xp5Rfe+AvovZ36Zn/VOQSDuodY4LYluz2FngjGfi
         cmqqTrGJRLITt5m18P3UOXu6wSODlaOdLJsoCNWGYuqLMhudtvEv0IYmT7Mcghl1cjKs
         26bwDzmSBD2uxr2aaR4IldkaEn4r6WyynRHEETFzRCwZ7E49uAhWDo7OJ1pF/Q5x4R3m
         HPKgtp5wKFVyrr7bniwJDTkbcfDdgbNAaGQUDmf/NGZA14C8vKv+DopKLlSRzL8X5NIv
         A14A==
X-Forwarded-Encrypted: i=1; AFNElJ92+/di/LZOb3ls9fk6FLvFPZrHBknyh+ynXuNwB3OBdmCElDHqHMqafvEtZyi9qM85OaPMX30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS99vVPTnOpExvt9XPbcEMuvGggtxbY5krFzBdye3PXvzexoXJ
	As7aKXcoHrnZWjNK3eOJrteEVjHgazcIF5ww8+bytB0YsEo1p/OZrkiMrv43b1vcbmHQiIZDote
	74a5SLLCLb8N+miAcqPTqNHy0wL9EMRY=
X-Gm-Gg: Acq92OH9X0J2EvJ6r5jeJpWlYJMVmOKqXF5cXqQlME+yFbd71HG+pdx89OBgii3cs0W
	C8oKw6gVJPvuZBk7emDz05AeNK9gW4awVcJGLl41s+Se7uHTQ9nYmusDb1MFHhjvqJEtqxyHRzI
	toETP7h34cIaE5dNbaXum40tDWW5wVQFSfsaiN/RGMJuZASsOHo8Yrzs4FKVINQpKZcItFjSZiV
	G5h5m15RrSHZm9a0CsSBHogLWpIBfwu7jr68KtHUTt27qokkrgVuj/VCE/Ewcy+eCQx/eOzRXxT
	bhDTkikSubHJUmAFbrUbKehO4DVprhrRkprfpvCRJG1gSJSuuiBYcCmuUqgz/g==
X-Received: by 2002:a05:690c:eca:b0:7de:795e:e9d7 with SMTP id
 00721157ae682-7f2b7c2d097mr78205757b3.39.1781095836145; Wed, 10 Jun 2026
 05:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610120812.49054-1-laoar.shao@gmail.com> <1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
 <CALOAHbBeBez2DAQD+1PPc1Dmm0HH0PQcytG-eaxgWyThRt890A@mail.gmail.com> <dd10cb23-261c-40b1-8b33-15a519f366c8@blackwall.org>
In-Reply-To: <dd10cb23-261c-40b1-8b33-15a519f366c8@blackwall.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 Jun 2026 20:49:59 +0800
X-Gm-Features: AVVi8CfDkC3P8K0S_DlM1GDHOD1BZ6Al6c_TSRDSsURZmpP6UUVBG938cgkSHhQ
Message-ID: <CALOAHbAnKP96ZZrVZw8duABJTUhmdcUZ_yWcJoRdjCCV9_pb2g@mail.gmail.com>
Subject: Re: [PATCH net-next] bonding: add sysfs interface for broadcast_neighbor
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Tonghao Zhang <tonghao@bamaicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297669-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:tonghao@bamaicloud.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,blackwall.org:email,mail.gmail.com:mid,bamaicloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 631056698C0

On Wed, Jun 10, 2026 at 8:45=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 10/06/2026 15:39, Yafang Shao wrote:
> > On Wed, Jun 10, 2026 at 8:30=E2=80=AFPM Nikolay Aleksandrov <razor@blac=
kwall.org> wrote:
> >>
> >> On 10/06/2026 15:08, Yafang Shao wrote:
> >>> The upstream kernel has supported broadcast_neighbor for 802.3ad mode=
 since
> >>> commit ce7a381697cb ("net: bonding: add broadcast_neighbor option for=
 802.3ad").
> >>> When upgrading from our local kernel to 6.18.y stable, we switched fr=
om our
> >>> out-of-tree implementation to the upstream one.
> >>>
> >>> However, the iproute2 package on our production servers is too old to
> >>> support the broadcast_neighbor option. To enable this feature, add a =
new
> >>> sysfs attribute at:
> >>>
> >>>     /sys/class/net/<bond>/bonding/broadcast_neighbor
> >>>
> >>> This allows enabling the feature by writing "1" to the sysfs file, ma=
tching
> >>> the interface we previously maintained in our local kernel.
> >>>
> >>> The result is as follows,
> >>>
> >>> - For 802.3ad mode
> >>>
> >>>     $ ip link add bond0 type bond mode 802.3ad
> >>>     $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
> >>>     0
> >>>     $ echo 1 > /sys/class/net/bond0/bonding/broadcast_neighbor
> >>>     $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
> >>>     1
> >>>
> >>> - For other modes
> >>>
> >>>     $ ip link add bond1 type bond
> >>>     $ cat /sys/class/net/bond1/bonding/broadcast_neighbor
> >>>     0
> >>>     $ echo 1 > /sys/class/net/bond1/bonding/broadcast_neighbor
> >>>     bash: echo: write error: Permission denied
> >>>
> >>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>> Cc: Tonghao Zhang <tonghao@bamaicloud.com>
> >>> ---
> >>>    drivers/net/bonding/bond_sysfs.c | 12 ++++++++++++
> >>>    1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/b=
ond_sysfs.c
> >>> index eaba44c76a5e..24eb23634d98 100644
> >>> --- a/drivers/net/bonding/bond_sysfs.c
> >>> +++ b/drivers/net/bonding/bond_sysfs.c
> >>> @@ -750,6 +750,17 @@ static ssize_t bonding_show_ad_user_port_key(str=
uct device *d,
> >>>    static DEVICE_ATTR(ad_user_port_key, 0644,
> >>>                   bonding_show_ad_user_port_key, bonding_sysfs_store_=
option);
> >>>
> >>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
> >>> +                                            struct device_attribute =
*attr,
> >>> +                                            char *buf)
> >>> +{
> >>> +     struct bonding *bond =3D to_bond(d);
> >>> +
> >>> +     return sysfs_emit(buf, "%d\n", bond->params.broadcast_neighbor)=
;
> >>> +}
> >>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
> >>> +                bonding_show_broadcast_neighbor, bonding_sysfs_store=
_option);
> >>> +
> >>>    static struct attribute *per_bond_attrs[] =3D {
> >>>        &dev_attr_slaves.attr,
> >>>        &dev_attr_mode.attr,
> >>> @@ -789,6 +800,7 @@ static struct attribute *per_bond_attrs[] =3D {
> >>>        &dev_attr_ad_actor_system.attr,
> >>>        &dev_attr_ad_user_port_key.attr,
> >>>        &dev_attr_arp_missed_max.attr,
> >>> +     &dev_attr_broadcast_neighbor.attr,
> >>>        NULL,
> >>>    };
> >>>
> >>
> >> Then update your iproute2 package, sysfs use for options is discourage=
d
> >
> > Could you please explain in detail why this is discouraged?
> >
> >> and is not being extended on purpose. Move to netlink.
> >
>
> Networking has been moving to netlink-only options for awhile now. Check =
for
> example:
> 1e16f382ae0b ("net: bridge: add warning comments to avoid extending sysfs=
")
>
> The preferred way to configure device types is via iproute2/netlink.

Thanks for your explanation, but I still don't understand the benefit
of it. Could you elaborate further?

--=20
Regards
Yafang

