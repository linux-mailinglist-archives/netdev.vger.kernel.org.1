Return-Path: <netdev+bounces-28331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2339877F121
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6B4281DD4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3A2119;
	Thu, 17 Aug 2023 07:25:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3FC2100
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:25:16 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297251BFB
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:25:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so9606547a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1692257113; x=1692861913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dGKJDnOixpZRKUNmsPrrtuABlxPSqTVyri1B1X6VJk=;
        b=Iur3dgTJvnKVwZxWIcrZnSyBmFsfHwRiYS/DeU3VT8J7mA2LIGQImPFPupDYld1HtW
         MUvru0nQDl0KnD2xFeRIRVLnTcEdTO/I63EURRDoOSFsuvJlVEvQsOedYkLCu6R2SuK7
         jNXXhZ8ssc3sawkzudptfTCmWhxrZOmeHfLv1BVhnwzLWqxoJmJaH4MNR+aA0GVd8VJh
         1preBIOm0AcJy+GvTDWetMU6f5Y3L44M6DiX8kNMv1nIrbEcNHbIe5VMXDljaFpyOTIh
         vW5S7eqsxtT0lCxz/SjZbx7s8h4sIaDu/Q+2zBLxQ/gR5Uhe399/hifIvDTjcDsUwp/V
         JX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692257113; x=1692861913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dGKJDnOixpZRKUNmsPrrtuABlxPSqTVyri1B1X6VJk=;
        b=FLoOWHcO9gDt1joUEmcjQK/WILcyzM5lhj6w7UhYJkv7XnL5OBMJcmQIm+3JtLqcBN
         xtSb/q3vAxQXYOjaQCgzwFZQMaPKiZi93GHu15Jy2q6dwLgK6nA6m2ZHv8+JVWSI+zu6
         pP0QetiIb1Ofylco45UCpqYHXMafnqMIHuwfVunm4rttQu5W+lVgZ/0WQBVmfZqJaZc2
         w5tqlbn0bZy7/zG6wR/x5NGg7LlKyHOELj/S6Ye+yEVVb2kOe/Z13wl3DYEV1h96PnNS
         h9KEFgoRW7vtPYmbFAGjRH6SeFNarHpcmj3p3GUewSbKCRSTZy7WspEvQX4DaZ0dlH17
         zrag==
X-Gm-Message-State: AOJu0YzY34MODYJKD4kjzCKVhIcExGmLz0K9RzxaHH+McAnIM3eG5yvY
	7HHPMOpEkGi712h4Au8k2CSIcw7/pAgxfq+N3O3g/D6DPbdqyCpP
X-Google-Smtp-Source: AGHT+IHts8nqdkQ/HEajD6HpPpreCJYmpVGr6Ks1lOLejQaPTTFZuG8tt7zyYuaNYw9gn/GNW9J4jUC9M0xLW0LxcTw=
X-Received: by 2002:aa7:cb51:0:b0:525:6d74:7120 with SMTP id
 w17-20020aa7cb51000000b005256d747120mr3369373edt.17.1692257113338; Thu, 17
 Aug 2023 00:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMGffEm-OUf0UqeqCbcWM8j1q1EaSObEUGFPZqFsH4sKGkis8g@mail.gmail.com>
 <20230816200120.603cc65a@kernel.org> <CACKFLinLofP3Ck03Vvs82_z4mhAfincF_qGFL=dKXKXOJTksdg@mail.gmail.com>
In-Reply-To: <CACKFLinLofP3Ck03Vvs82_z4mhAfincF_qGFL=dKXKXOJTksdg@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 17 Aug 2023 09:25:02 +0200
Message-ID: <CAMGffE=7pMtOOo2W+TtY84U8F5EQ9f9jRMSDU9kT+4_MOF_dTg@mail.gmail.com>
Subject: Re: [RFC] bnxt_en TX timeout detected, starting reset task, flapping
 link after
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Michael, hi Jakub,

Thx for the help.

On Thu, Aug 17, 2023 at 9:08=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Wed, Aug 16, 2023 at 8:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 16 Aug 2023 20:51:25 +0200 Jinpu Wang wrote:
> > > Hi Michael, and folks on the list.
> >
> > It seems you meant to CC Michael.. adding him now.
> > I don't recall anything like this. Could be a bad system...
>
> I agree that it could be a bad NIC or a bad system.
Surprisingly, we had the same symptom, one after another, we suppose
it might be workload specific, once we migrate some workload from
first problematic server to the second server,  4 hours later the
second server also hit same problem. until we disabled some offload
via ethtool, the system became stable again.


>
> >
> > > kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251006] bnxt_en
> > > 0000:45:00.0 eth0: [0]: tx{fw_ring: 0 prod: 1e7 cons: 1e4}
>
> TX ring 0 is timing out with prod ahead of cons.
>
> > > kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251015] bnxt_en
> > > 0000:45:00.0 eth0: [2]: tx{fw_ring: 2 prod: af cons: 9b}
>
> TX ring 2 is also timing out.
>
> > > kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251022] bnxt_en
> > > 0000:45:00.0 eth0: [4]: tx{fw_ring: 4 prod: d4 cons: d2}
>
> Same for TX ring 4.
>
> > > kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251027] bnxt_en
> > > 0000:45:00.0 eth0: [6]: tx{fw_ring: 6 prod: 63 cons: 120}
>
> TX ring 6 is ahead by a lot.
>
> > > kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326019.874938] bnxt_en
> > > 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> > > kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326019.884991] bnxt_en
> > > 0000:45:00.0 eth0: hwrm_ring_free type 1 failed. rc:fffffff0 err:0
>
> This means that during reset, we're timing out when trying to free the
> TX ring (type 1).  There are exactly 4 of these type 1 ring free
> errors, probably matching the 4 TX rings that timed out.  There are
> also 7 type 2 (RX ring) errors.  This makes some sense because by
> default there are usually 2 RX rings sharing the same MSIX with 1 TX
> ring.  So 7 out of 8 RX rings associated with the TX rings also failed
> to be freed.
>
> > >
> > > I checked git history, but can't find any bugfix related to it. The
> > > internet tells me it could be a
> > > firmware bug, but I can't find firmware from Broadcom site or supermi=
cro site.
> > >
>
> I will have someone reach out to you to help with newer firmware.
That will be great.

Could Broadcom add bnxt_en firmware also to linux-firmware like bnx2?
that will ease people's life like me.

Thx again.

  Thanks.

