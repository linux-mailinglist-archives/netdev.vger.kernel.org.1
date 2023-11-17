Return-Path: <netdev+bounces-48656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF67EF232
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD0F3B209F7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D0130325;
	Fri, 17 Nov 2023 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="S763iO/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D263A5
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 04:01:44 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5bf812041a6so21503207b3.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 04:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700222503; x=1700827303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDwD6W+ZvLJ/uD1ofGhdBMpFkfiETfNjdAYoTLOib5Y=;
        b=S763iO/+PAQw9ER8moMBqfzz4CM1odsR2V4iu56sfHywafs3Q5I9+nRK8mI9fLHBrh
         g9j2i0g0K0Us6qvDq/N8UuKIHqOmdbB5nDaImfy5Sq+ZQ311IMCRNZqqyqwXb4IkrMVs
         UzRUQsqoCuUWIZEtN/2mhV4xSEwH3DQwF81an2Vdc0cY5oLL72OE3OrhhNq6vVS8QNqM
         t3moqSF0KG2zqVI6MskMGeiFga1RHYnbZkHEI/VonWBxhfjnQP89ndXCcIwZX9HKzdJq
         1/6spEJWOXJleAW/Rs1Q4HsJIGbL3y7mKI4A0g4YlN+RVBkBU56ResfGnwPoCpO/pVYY
         BHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700222503; x=1700827303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDwD6W+ZvLJ/uD1ofGhdBMpFkfiETfNjdAYoTLOib5Y=;
        b=F5auzEOkg+rnh+8KKnVuMCCym8k37kvQZeZACNXl5N6n1XCaj9Klj3lyHBRGnZrpRN
         b2HDt3u8GFPM1eYux84b/OweM35CkA/S9KHsEtkJkvH70+WiI0cbESuRfk3xjcDySHIe
         QzHQ6q20BV2XSj5fWNUHwycw1Z7CKI+P3JxRokmzJZJqUV1nbW5d1VuGFLbS+3sxQbWF
         Drx1RW3BXLbWG2wmLWPp4Ge/Uf//ot60+v2s+MrKHnVafqmV2mXaAPCJVAd04/Znj3Bb
         bhG/oaoEUjYJG3p3hppgrqSUSNDORUMY/9R/3PPPcJupXd4ZVQD6GfmgM4lE5joEBljc
         AbJQ==
X-Gm-Message-State: AOJu0YwDdhzcRh22R6km6C6XLAw0OpObQJyMZgizpyeaYNOvNkt3diEi
	T58ERquimqCKXjFIFS5wrKQIwkelgTHq8BXxHVlqUA==
X-Google-Smtp-Source: AGHT+IEZYMc5Vp6np/f/v1WiPg0SgQ2n61Vk0+eItYogKSPqBuWCb8Nlo+EnP01sur6opFcpgSW+AfkDVb/8pB7RUWY=
X-Received: by 2002:a0d:ed46:0:b0:5be:6d5c:1031 with SMTP id
 w67-20020a0ded46000000b005be6d5c1031mr19024252ywe.17.1700222503351; Fri, 17
 Nov 2023 04:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <20231116145948.203001-9-jhs@mojatatu.com>
 <ZVY9aQW0C8kxq0xA@nanopsycho>
In-Reply-To: <ZVY9aQW0C8kxq0xA@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 17 Nov 2023 07:01:31 -0500
Message-ID: <CAM0EoMmHVeMCcUKbuoA6A3r+riAdS8jjr8hTn-9cxM1Um3F7rA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 08/15] p4tc: add P4 data types
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:03=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Nov 16, 2023 at 03:59:41PM CET, jhs@mojatatu.com wrote:
>
> [...]
>
> >diff --git a/include/net/p4tc_types.h b/include/net/p4tc_types.h
> >new file mode 100644
> >index 000000000..8f6f002ae
>
> [...]
>
> >+#define P4T_MAX_BITSZ 128
>
> [...]
>
> >+#define P4T_MAX_STR_SZ 32
>
> [...]
>
>
> >diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
> >new file mode 100644
> >index 000000000..ba32dba66
> >--- /dev/null
> >+++ b/include/uapi/linux/p4tc.h
> >@@ -0,0 +1,33 @@
> >+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >+#ifndef __LINUX_P4TC_H
> >+#define __LINUX_P4TC_H
> >+
> >+#define P4TC_MAX_KEYSZ 512
> >+
> >+enum {
> >+      P4T_UNSPEC,
>
> I wonder, what it the reason for "P4T"/"P4TC" prefix inconsistency.
> In the kernel header, that could be fixes, but in uapi header this is
> forever. Is this just to be aligned with other TC uapi
> inconsitencies? :D
>

P4T is for "types" - but ok, we can change it to P4TC_XXX for consistency.

cheers,
jamal

