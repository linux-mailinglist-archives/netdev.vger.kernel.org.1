Return-Path: <netdev+bounces-38686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBEB7BC234
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE98E282067
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F144445F45;
	Fri,  6 Oct 2023 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y3SKA/dh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09B45F40
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 22:24:59 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A88FBE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 15:24:58 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40662119cd0so10865e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696631096; x=1697235896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah+07OPEhZZsuPf2759AKk30s58BSNVoBkJCXV+g2rA=;
        b=y3SKA/dh7RqieCZ3ebwPxW4EOi0ttcUfOJDXkkcNbj9i5LvZYIgpJUu4nmjMn3jjvk
         b0ep1w1BCNhwVIB3q6iyPuvKb/ph3f2kFi+4/0BaqgDd9dBrnhPomCeuWFud8VxS323s
         GMXBhu+5lKAaGGwTsTgXz59voyDsRUieNCmxIh1lOl0Ydfix9g+Uu676iLqoYspSrxCY
         RtN3C0ENzUuQHCkV4bJUu0TkIsZUzv4wR5t382bSOEE1+xtc+hICSLttGg/tKqYAPKYK
         EzGnjznH/K4xSCfgTx5bk3Z8XhJsdQRzw2fmzy/Y6zcwkyfodVXWCIh7fW5b1M5YrnKk
         x7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696631096; x=1697235896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ah+07OPEhZZsuPf2759AKk30s58BSNVoBkJCXV+g2rA=;
        b=IZ6nny4dZeBVlt7ADipOMWZ/i6G6fli2U7yCz+vi7RgiakBxWCbv7uT5qVyLFdOtx2
         EX+eq0T3oRGe2K1b8LAkHCjN6AdUc45yJqnycwSBQKthXu6Upt7zNyEC0pMkxeenH77z
         LUu+Q1AHLp20ayf0iD3hfb8kwdKLgiIsDJ+MolmZ3LuySxfj9bysn0pPHa6ci5ncZe6+
         UtdBjtU9bHf+U/8NeGZ80idDF6U1+JyfDHo6ZtLvewQf464ukEr2M0nqydwol6dThVPl
         RHgvR8bRJsnf3CGVZdSagcM9ttcU5LL/PFcDQ+HadXXMCZigMEcUmmLIyrsqxvTrz0GQ
         V3tw==
X-Gm-Message-State: AOJu0YwbBT1RmAolioYHc8FYhOAtDF2HQqnsvoOavItosNyM8yR6srkr
	sDDrelS9Hepn/+AM57EPR/AVfXcss90bCE8ueF/L
X-Google-Smtp-Source: AGHT+IEZPkPDsf0YOkHdCITZXimrrJgLwPv0OwkOJIjEuXMYg8QFraxv9qBvqwO1J62h/WLMS2ebJ9xhDuL3hBwcHaE=
X-Received: by 2002:a05:600c:1e25:b0:406:5779:181d with SMTP id
 ay37-20020a05600c1e2500b004065779181dmr221063wmb.2.1696631096239; Fri, 06 Oct
 2023 15:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003041701.1745953-1-maheshb@google.com>
In-Reply-To: <20231003041701.1745953-1-maheshb@google.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 6 Oct 2023 15:24:44 -0700
Message-ID: <CANDhNCrG7kY=zZxP=079iGHxsapmHj0Lo1-gCEmcLg3=qJomug@mail.gmail.com>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
To: Mahesh Bandewar <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>, Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 9:17=E2=80=AFPM Mahesh Bandewar <maheshb@google.com>=
 wrote:
>
> add support for TS sandwich of the user preferred timebase. The options
> supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONIC)=
,
> and PTP_TS_RAW (CLOCK_MONOTONIC_RAW)
>
> Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().
>
> Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> CC: Richard Cochran <richardcochran@gmail.com>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: netdev@vger.kernel.org
> ---
>  include/linux/ptp_clock_kernel.h | 51 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/ptp_clock.h   |  7 +++++
>  2 files changed, 58 insertions(+)

Hey Mahesh,
  Thanks for sending this out!  I've got a few thoughts below.


> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_k=
ernel.h
> index 1ef4e0f9bd2a..fd7be98e7bba 100644
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -102,6 +102,15 @@ struct ptp_system_timestamp {
>   *               reading the lowest bits of the PHC timestamp and the se=
cond
>   *               reading immediately follows that.
>   *
> + * @gettimex64any:  Reads the current time from the hardware clock and
> +                 optionally also any of the MONO, MONO_RAW, or SYS clock=
.
> + *               parameter ts: Holds the PHC timestamp.
> + *               parameter sts: If not NULL, it holds a pair of timestam=
ps from
> + *               the clock of choice. The first reading is made right be=
fore
> + *               reading the lowest bits of the PHC timestamp and the se=
cond
> + *               reading immediately follows that.
> + *               parameter type: any one of the TS opt from ptp_timestam=
p_types.
> + *
>   * @getcrosststamp:  Reads the current time from the hardware clock and
>   *                   system clock simultaneously.
>   *                   parameter cts: Contains timestamp (device,system) p=
air,
> @@ -180,6 +189,9 @@ struct ptp_clock_info {
>         int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *t=
s);
>         int (*gettimex64)(struct ptp_clock_info *ptp, struct timespec64 *=
ts,
>                           struct ptp_system_timestamp *sts);
> +       int (*gettimex64any)(struct ptp_clock_info *ptp, struct timespec6=
4 *ts,
> +                            struct ptp_system_timestamp *sts,
> +                            enum ptp_ts_types type);
>         int (*getcrosststamp)(struct ptp_clock_info *ptp,
>                               struct system_device_crosststamp *cts);
>         int (*settime64)(struct ptp_clock_info *p, const struct timespec6=
4 *ts);

So I don't see anything in this series that wires into this hook. Did
a patch go missing? Or am I maybe looking in the wrong place?


> @@ -464,4 +476,43 @@ static inline void ptp_read_system_postts(struct ptp=
_system_timestamp *sts)
>                 ktime_get_real_ts64(&sts->post_ts);
>  }
>
> +static inline void ptp_read_any_prets(struct ptp_system_timestamp *sts,
> +                                     enum ptp_ts_types type)
> +{
> +       if (sts) {
> +               switch (type) {
> +               case PTP_TS_REAL:
> +                       ktime_get_real_ts64(&sts->pre_ts);
> +                       break;
> +               case PTP_TS_MONO:
> +                       ktime_get_ts64(&sts->pre_ts);
> +                       break;
> +               case PTP_TS_RAW:
> +                       ktime_get_raw_ts64(&sts->pre_ts);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +}
> +
> +static inline void ptp_read_any_postts(struct ptp_system_timestamp *sts,
> +                                      enum ptp_ts_types type)
> +{
> +       if (sts) {
> +               switch (type) {
> +               case PTP_TS_REAL:
> +                       ktime_get_real_ts64(&sts->post_ts);
> +                       break;
> +               case PTP_TS_MONO:
> +                       ktime_get_ts64(&sts->post_ts);
> +                       break;
> +               case PTP_TS_RAW:
> +                       ktime_get_raw_ts64(&sts->post_ts);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +}

Similarly, I'm a little confused as to who the users of these two
functions are? I don't see them in this patch series.

Additionally it seems like instead of two functions, you could maybe
have one ptp_read_any_ts(enum ptp_ts_types type, struct timespec64
*ts) function that the caller passes the sts->pre_ts or sts->post_ts
to?

And finally, I'm not sure if it makes sense, but other logic in the
kernel that does similar clockid multiplexing includes
timens_add_monotonic() or timens_add_boottime() (though the latter
doesn't apply here) for namespace offsets.
I was never excited about time namespaces (hard enough to keep one
sense of time :), but there are some good reasons, and I suspect we
might want to avoid cases where clock_gettime() returns potentially
different values compared to this interface.

thanks again!
-john

