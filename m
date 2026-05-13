Return-Path: <netdev+bounces-287619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OdkHHmJBGoxLQIAu9opvQ
	(envelope-from <netdev+bounces-287619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:23:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACBE534FC6
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 881EE3028A9E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98154306749;
	Wed, 13 May 2026 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/MY+Hot"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC673093CB
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681255; cv=pass; b=Tbx9vOHq2wnQlMq2kQCDn0hBuaW6VJREkmwvGDrzgbgjVHZ3GCDiNpvOHdBPZNdA9XCDa6x2iyjW9tvNEDfP8uZBaSnS569u+JRTxcZLiA+CTJzhLRUQTQoDd/WF1E8bJw8c5F7wbP2Qef/JObaVKZeePZ67DLQjBxt0eiEIJOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681255; c=relaxed/simple;
	bh=KiH2cSs7szjoDYOPZZilL+L5FtBiKHccI1nnv3wLlLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4IsEYnkBIM17434OUi/zuhW6dkh/eyv3zfNmzDccKh1eRmF3zj9/mXOFg2DI+3JynQMPQlRO8MHNu8DPHI6CFUZdnCn1e/itLXpDMaGSk7Fxk6A5BFod7vxW5Sk81r59sYCMbo57fs8UXiN1GSyajHbLGQ0p2V07iD8aS5ni8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/MY+Hot; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-47cacb4ed99so4421621b6e.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778681253; cv=none;
        d=google.com; s=arc-20240605;
        b=cLQ9ZBuA4vV38i1aPjW/mF/jdYtYeyqP0cgQTBNJg5D6JrQs7wKDfPvWC+wiCDePDU
         wn2XteYxMb1SZSddIP3ILR9AnK0VLqkJXDQh5eYQiz1RS7d2BbPTobd4zNru8/l9sTeb
         rZ5UDmGPGA/dwV9pESyjTy6pci4towZGRt+m4Wf8SLgo4uL/FEVLk7ZKJvY+wXMT/1up
         3vxlSDYFrZaSX3713C7PvY/LwWckJNZSKgDmuDhBc11YvsNZbYxUus2lw05Vhw3Oes0b
         v6fl+BMj4ilIERpbvQDT7HV7IHIEuhteKpdkfwWA3IxJD5VCvQfH1fMWRyyWYnX/CD+D
         XR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZUQuQQdqf/p8+tvLlpf7lmWMBB33o/duQyQpfVvrpo=;
        fh=/QJJufBcy9kbNioCB5NppYD7vdxjX7U1LaFuYaASCf0=;
        b=Olm6loAoARXllJvHuWVFbTcQQN81fFcCZKW2lYn3sqWJ1bmhaRszujGMZkJ9781Epm
         fBjld3r5CAJU9QgXKXiE/rNDLK7czsH+z39XlqyPkkxBdek+Tbt74bTQN7gumSYm2eJw
         4X2NtnnpvH8WgSiWVmKmWOf6CUlSmtDHP6KPhCbzZlr7l656IK9YTb2jAW9dbU0WNzio
         6TwyzlLiYGOmN/iatxaU4ktElxWqejLJcmCaO5D0Xuri83M8yFrZ5eZmUdNnBAsO4UiB
         FV22SSGXdGYh0pUh6bwaokufy890XboYegy4h6ezrG4Tpq2tR5FaqYBYHYV+NnBbOc0c
         XgLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778681253; x=1779286053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZUQuQQdqf/p8+tvLlpf7lmWMBB33o/duQyQpfVvrpo=;
        b=n/MY+Hot6QcQahm6sTGwqfW+DQUvljYiFEt/uPYn16hXh+BlPa9Z4AEYqYINeMbytU
         eGcuZE+6p6jxgNcQceWzojHqNBpBBnSzIc5Jxcke5DGAhAHmrhOoelHLZmr+vlUS337l
         TVkJuUnuK0/j9xa0jjepsvEDxgwF4MdDdnpgFjNCDCrRzfxqPHd7mg4wZR+ghv8MJYc1
         ke0Rtn6+rtAAVZWPqvVeI9cDABuKWiXo05ifUP/+YvVuayEJ2yfYiCPo6fDS8G/i1nW6
         9FzsSKAnNxbUN4FrxS3qgzGuMNQ6Eska/JiHQecftDRXbxefNwahTitdBD5lUIozq+Bx
         OnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778681253; x=1779286053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZUQuQQdqf/p8+tvLlpf7lmWMBB33o/duQyQpfVvrpo=;
        b=dY7JXXzie17MUHpCDL6Erq4ij0PT4yIz8FLNhr5u5Fp3y1CNowEKATuh0qfYEQ1AMh
         G28cjeneH2CEKIaPVkjPpnQfPgg24r3HPuXAnTQ3Ms5oI/8ylcPv2MQpwCBtxaiDb0HS
         dPPXLaX+xO8n+PC1bB5td3LpxltwbAIpFh47zufWgYtv59BH56MK6bAYp8a9VpzsBtKg
         IeA+3p1ggJ48BUe4TftvMGPvAojdj7oQ9D54ALZi0enLIk1zX7twUrT8fGXhxd1JHm+r
         KvOwzh9wpVdf7HJX8ZN3imedmNwKQ4BGG7QRTGSHztzuVX63u0g/Q5ubUFzcV20V9ST0
         t8Rw==
X-Forwarded-Encrypted: i=1; AFNElJ/gx2ZfOzOj6CPszybXjlQFyc7X2YYaC2oJewIiv+qL92wP51KdOsFd719MWol2ltuMWi1HFeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbFARS6MdJ/TnPWwdbFJ6VKLcOkhpj54xYA9aXMjzLYA9FgPi
	GKMfhIIU2gqdCWaAwn9gWxZ4ZD44wBqR8NU3ZaED1oLhBj6T2JoJ0T/xxVhjfkF+USAAMf/ApVX
	vBRurSknxEUAK5ZaTQ8Ak26ZwvzjvPsc=
X-Gm-Gg: Acq92OH3cEY6SlZ4+8Vat9sJ7tefvPTFTD5z0uEs1tJc9XVrZytEBJwW92ch9CntfzN
	1iR9op7uyWmTaI0g1nBfWFW+FlhKXw3/wq8c+uU+yL8q8oHCLo+6AhqkDGfrl5ANYeWimJ/3PVt
	MaNZQek/1im/wxRdKOrSZ83SyFXJfHh0QpTvZIkY7gpbOJScF8REvt5/JtZjCC+/G3ZnGTtcCs8
	kurqwKQcE9sO1HsWEV/mOdpI1gh8MHR0E5hF9AcnJIp6qP9YmegQecdFA/tLsezKCK4gKmF8W4a
	4kjPhcIsljxj/Hcq1+vEezF3JCcIpN0W08xN+w==
X-Received: by 2002:a05:6808:6f95:b0:482:52f6:b688 with SMTP id
 5614622812f47-482b2dc22aemr2347906b6e.45.1778681252569; Wed, 13 May 2026
 07:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512060627.3781329-1-danishanwar@ti.com> <20260512060627.3781329-2-danishanwar@ti.com>
 <CA+XhMqykBWcMdk+iNnOtUxM4MX6jpDyUwfuAVZFbjAShO9_v7Q@mail.gmail.com>
 <6a1f411c-d7ed-463b-abf1-277d8cc0c184@ti.com> <CA+XhMqzx9CUX5H7q1UqL=heGWLFjZVfyiTx6b45VW=E9t13Fow@mail.gmail.com>
 <54fae7f6-fcb9-4520-a79a-569426ab96f1@ti.com>
In-Reply-To: <54fae7f6-fcb9-4520-a79a-569426ab96f1@ti.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 13 May 2026 15:07:21 +0100
X-Gm-Features: AVHnY4Imr3ifI6YaYwnvbYhsd7iy4zZNn_0tDZdtLYE2rwmadFPIDaEPiFNCvU0
Message-ID: <CA+XhMqxoFZskFmjtxWXkdUbzBR2LzexaLohRKkCKxFJrmJetfg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: ti: icssg: Derive stats array lengths
 from ARRAY_SIZE
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jacob Keller <jacob.e.keller@intel.com>, Meghana Malladi <m-malladi@ti.com>, 
	Kevin Hao <haokexin@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1ACBE534FC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287619-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,intel.com,ti.com,gmail.com,linux.dev,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ti.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 at 07:29, MD Danish Anwar <danishanwar@ti.com> wrote:
>
> Hi David
>
> On 12/05/26 3:33 pm, David CARLIER wrote:
> > Hi Danish,
> >
> >
> > On Tue, 12 May 2026 at 10:40, MD Danish Anwar <danishanwar@ti.com> wrot=
e:
> >>
> >> Hi David,
> >>
> >> On 12/05/26 1:28 pm, David CARLIER wrote:
> >>> Hi MD,
> >>>
> >>> On Tue, 12 May 2026 at 07:06, MD Danish Anwar <danishanwar@ti.com> wr=
ote:
> >>>>
> >>>> Replace the manually maintained ICSSG_NUM_MIIG_STATS and
> >>>> ICSSG_NUM_PA_STATS constants with ARRAY_SIZE() expressions derived
> >>>> directly from the corresponding stat descriptor arrays, so that addi=
ng
> >>>> new entries to icssg_all_miig_stats[] or icssg_all_pa_stats[] no lon=
ger
> >>>> requires a separate update to a numeric constant.
> >>>>
> >>>> To make this self-contained, break the circular include dependency
> >>>> between icssg_stats.h and icssg_prueth.h:
> >>>>
> >>>>   - icssg_stats.h previously included icssg_prueth.h (transitively
> >>>>     pulling in icssg_switch_map.h and ETH_GSTRING_LEN).  Replace tha=
t
> >>>>     with direct includes of <linux/ethtool.h>, <linux/kernel.h> and
> >>>>     "icssg_switch_map.h".
> >>>>
> >>>>   - icssg_prueth.h now includes icssg_stats.h, giving it access to
> >>>>     the ARRAY_SIZE-based ICSSG_NUM_MIIG_STATS and ICSSG_NUM_PA_STATS
> >>>>     before they are used in the prueth_emac struct and ICSSG_NUM_STA=
TS.
> >>>>
> >>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >>>> ---
> >>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h | 3 +--
> >>>>  drivers/net/ethernet/ti/icssg/icssg_stats.h  | 7 ++++++-
> >>>>  2 files changed, 7 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/=
net/ethernet/ti/icssg/icssg_prueth.h
> >>>> index df93d15c5b78..e2ccecb0a0dd 100644
> >>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> >>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> >>>> @@ -43,6 +43,7 @@
> >>>>
> >>>>  #include "icssg_config.h"
> >>>>  #include "icss_iep.h"
> >>>> +#include "icssg_stats.h"
> >>>>  #include "icssg_switch_map.h"
> >>>>
> >>>>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
> >>>> @@ -57,8 +58,6 @@
> >>>>
> >>>>  #define ICSSG_MAX_RFLOWS       8       /* per slice */
> >>>>
> >>>> -#define ICSSG_NUM_PA_STATS     32
> >>>> -#define ICSSG_NUM_MIIG_STATS   60
> >>>>  /* Number of ICSSG related stats */
> >>>>  #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
> >>>>  #define ICSSG_NUM_STANDARD_STATS 31
> >>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/n=
et/ethernet/ti/icssg/icssg_stats.h
> >>>> index 5ec0b38e0c67..b854eb587c1e 100644
> >>>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> >>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> >>>> @@ -8,10 +8,15 @@
> >>>>  #ifndef __NET_TI_ICSSG_STATS_H
> >>>>  #define __NET_TI_ICSSG_STATS_H
> >>>>
> >>>> -#include "icssg_prueth.h"
> >>>> +#include <linux/ethtool.h>
> >>>> +#include <linux/kernel.h>
> >>>> +#include "icssg_switch_map.h"
> >>>>
> >>>>  #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
> >>>>
> >>>> +#define ICSSG_NUM_MIIG_STATS   ARRAY_SIZE(icssg_all_miig_stats)
> >>>> +#define ICSSG_NUM_PA_STATS     ARRAY_SIZE(icssg_all_pa_stats)
> >>>> +
> >>>>  struct miig_stats_regs {
> >>>>         /* Rx */
> >>>>         u32 rx_packets;
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>
> >>> One thing that caught my eye: icssg_all_miig_stats[] and
> >>>   icssg_all_pa_stats[] are 'static const' arrays in icssg_stats.h wit=
h
> >>>   ETH_GSTRING_LEN name buffers per entry. Right now only icssg_stats.=
c
> >>>   and icssg_ethtool.c pull them in. After this patch icssg_prueth.h
> >>>   includes icssg_stats.h, so every .c in the driver (classifier,
> >>>   common, config, mii_cfg, queues, switchdev, ...) ends up with its o=
wn
> >>>   static-const copy of both tables.
> >>>
> >>>   Would a static_assert() work for what you're after? Something like:
> >>>
> >>
> >> While adding more stats manually, The ARRAY_SIZE() approach was
> >> explicitly requested by maintainer [1]:
> >>
> >> This patch is a direct response to that feedback. static_assert() woul=
d
> >> still require updating the numeric constant on every array change. The
> >> goal here is to eliminate the need of manually incrementing stats coun=
t
> >> whenever new stats are added
> >>
> >> Your concern about multiple copies of table is noted and valid. Could
> >> you advise on the preferred way to reconcile these two requirements? I
> >> am happy to restructure if there is an approach that satisfies both.
> >>
> >> [1]
> >> https://lore.kernel.org/all/20260112181436.4s5ceywwembn674r@skbuf/#:~:=
text=3DCan%27t%20this%20be%20expressed%20as%20ARRAY_SIZE(icssg_all_pa_stats=
)%3F%20It%20is%20very%0Afragile%20to%20have%20to%20count%20and%20update%20t=
his%20manually.
> >>
> >>
> >>>     static const struct icssg_miig_stats icssg_all_miig_stats[] =3D {
> >>>         ...
> >>>     };
> >>>     static_assert(ARRAY_SIZE(icssg_all_miig_stats) =3D=3D ICSSG_NUM_M=
IIG_STATS);
> >>>
> >>>   next to each array, keeping the numeric #defines as-is. Then 2/2 fa=
ils
> >>>   to build the moment a new entry is added without bumping the count,
> >>>   which is the case you're guarding against =E2=80=94 without touchin=
g the
> >>>   include graph.
> >>>
> >>> What do you think ?
> >>>
> >>> Cheers.
> >>
> >> --
> >> Thanks and Regards,
> >> Danish
> >>
> >
> >
> >   Thanks for digging up the context =E2=80=94 fair point, I'd missed Vl=
adimir's
> >   earlier ask. Reading it again though, what he calls fragile is the
> >   silent miscount, not the keystroke of typing a number. A static_asser=
t
> >   turns "forgot to bump" into a build error, which I think gets you
> >   there.
> >
>
> Thank you for the suggestion. I think your previous suggestion fits
> better. I believe keeping the arrays in icssg_stats.h is preferable to
> moving them to icssg_stats.c. Here is my reasoning:
>
>
> Your binary-bloat concern was about icssg_prueth.h including
> icssg_stats.h, which would drag the static const tables into every .c
> that includes icssg_prueth.h (~11 translation units). That concern is
> valid, but it is specific to the include direction of the previous
> patch. If we simply revert to the original include graph =E2=80=94
> icssg_stats.h includes icssg_prueth.h, not the other way around =E2=80=94
> only the two files that have always included icssg_stats.h directly
> (icssg_stats.c and icssg_ethtool.c) get a copy of the arrays. No
> regression in binary size compared to the baseline.
>
> >   What about moving the two arrays into icssg_stats.c, declaring them
> >   extern in the header, and dropping a static_assert next to each
> >   definition? Numeric #defines stay where they are, icssg_prueth.h
> >   doesn't need to know about icssg_stats.h, and the tables live in one
> >   TU instead of every .o in the driver. If the count and the array
> >   disagree, you get a compile error on the spot.
> >
>
> Moving the arrays to icssg_stats.c (approach #2) adds extern
> declarations, splits the definition from the static_assert, and is a
> larger restructuring for the same safety guarantee. Keeping the arrays
> in the header with a static_assert immediately after each one is a
> 2-line diff and leaves the code easy to read in one place.
>
> Please let me know if this sounds okay to you. I will send out a v2 soon
> if this approach is fine with you.

Sounds fine by me, note that I am not a maintainer ;  I was just "chiming i=
n" ;)

Cheers !

>
> >   Probably worth keeping Vladimir on Cc for v2 in case he had something
> >   else in mind.
> >
>
> I will CC Vladimir in v2.
>
> --
> Thanks and Regards,
> Danish
>

