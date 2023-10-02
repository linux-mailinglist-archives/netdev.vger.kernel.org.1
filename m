Return-Path: <netdev+bounces-37440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A77B5595
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 8BEBEB20CB5
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F801A72D;
	Mon,  2 Oct 2023 15:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885F1A727
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:00:53 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9FBD
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:00:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-327b7e08456so1570712f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696258849; x=1696863649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkzGa2NxcO0pxnOMibbgAoclGRI+KHmZWNdvoqM0EiE=;
        b=VnlwM89AGl2I4yeXst4XNsTpe5PxipuYZgDVih/dkXp6dWXu9M+1e7+n6ZTMsYZRQx
         Ddg1GFMdw8OpGnJ2QmUwP3Gez/0eEbzKmajQcVxg1UOLdbtRqItLfN/VqGw9gO3ce07A
         IcvkarhSxzA1b84nvFs1ZCWlzrkZHD6YN+xCX9rlN0YdmApCAGOAmP1QIwT/7QvW3Qjy
         HXo4k9CtVyllSzqhqYWNE0xcBDFYRS4CNQzHeZdN3pb8YqCC7FtoAnAWgFdz8mIui8zx
         9fIcfLr2Wk8/5lMjTpp0Vl4p7UgDyDB4fVEOyXWm1ixZCRTl1q6hLnxNLcuIUHVW+yTc
         h80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696258849; x=1696863649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkzGa2NxcO0pxnOMibbgAoclGRI+KHmZWNdvoqM0EiE=;
        b=eHr/BM0ULi2txXjoVY+gDoQeffujfw+Zh9LEFS7MPgUHi64V++Gy+C3059pp++W6CG
         wGtAB3hOLEucvGFy4GlJECR1RNE+Twyhx10EYiwdRGJG08abMAJHBE4lSdrAV3mFBUns
         lmTjCTsc2JeJ3MjM4tmduVt6gTgrx9xFGmDkeSUwvt8wwhVZ7btoTkQpFvoxIpHX0wyK
         ++uNKVD+Ncf7sduO2YpfAh+e2SWh5Xt7vqhK0D9kWZNxi4wFziQRpAuECD4/CqiTU1lc
         +4VuK6lw0py/xq7iMb1s02/R2Mt0EKShYaNJq+Rjvy5r8p10gru5OHN6okBeMdjkhkFz
         0zMg==
X-Gm-Message-State: AOJu0YwSnG4cSTdBi0k8AiP+dyFeMp+VEkO8HjLo0ZjfeJMxY/Huh+o3
	ju7Wmx6aKNo3ahopNP56ApYb6A==
X-Google-Smtp-Source: AGHT+IHrmlnt9I95atsKI9gbnPrSdt+pQfKReIyEPo4bPCSEjPbgKCtgw/CbTF6jX9PR2dx50R4oNQ==
X-Received: by 2002:a05:6000:1112:b0:31f:d3e3:a53d with SMTP id z18-20020a056000111200b0031fd3e3a53dmr10800356wrw.2.1696258849324;
        Mon, 02 Oct 2023 08:00:49 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id kb23-20020a1709070f9700b009944e955e19sm17070887ejc.30.2023.10.02.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:00:48 -0700 (PDT)
Date: Mon, 2 Oct 2023 17:00:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next 1/4] dpll: docs: add support for pin signal
 phase offset/adjust
Message-ID: <ZRrbH4gdfOg9TmV3@nanopsycho>
References: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
 <20230927092435.1565336-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927092435.1565336-2-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Sep 27, 2023 at 11:24:32AM CEST, arkadiusz.kubalewski@intel.com wrote:
>Add dpll documentation on new pin's attributes:
>- phase-offset - measured difference between phase of signals on pin
>  and dpll
>- phase-adjust - adjustable value of pin's signal phase
>- phase-adjust-min / phase-adjust-max - values for determining limits
>  for phase-adjust
>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> Documentation/driver-api/dpll.rst | 53 ++++++++++++++++++++++++++++++-
> 1 file changed, 52 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
>index bb52f1b8c0be..59634a3513bd 100644
>--- a/Documentation/driver-api/dpll.rst
>+++ b/Documentation/driver-api/dpll.rst
>@@ -173,6 +173,47 @@ in order to configure active input of a MUX-type pin, the user needs to
> request desired pin state of the child pin on the parent pin,
> as described in the ``MUX-type pins`` chapter.
> 
>+Phase offset measurement and adjustment
>+========================================
>+
>+Device may provide ability to measure a phase difference between signals
>+on a pin and its parent dpll device. If pin-dpll phase offset measurement
>+is supported, it shall be provided with ``DPLL_A_PIN_PHASE_OFFSET``
>+attribute for each parent dpll device.
>+
>+Device may also provide ability to adjust a signal phase on a pin.
>+If pin phase adjustment is supported, minimal and maximal values that pin
>+handle shall be provide to the user on ``DPLL_CMD_PIN_GET`` respond
>+with ``DPLL_A_PIN_PHASE_ADJUST_MIN`` and ``DPLL_A_PIN_PHASE_ADJUST_MAX``
>+attributes. Configured phase adjust value is provided with
>+``DPLL_A_PIN_PHASE_ADJUST`` attribute of a pin, and value change can be
>+requested with the same attribute with ``DPLL_CMD_PIN_SET`` command.
>+
>+  =============================== ======================================
>+  ``DPLL_A_PIN_ID``               configured pin id
>+  ``DPLL_A_PIN_PHASE_ADJUST_MIN`` attr minimum value of phase adjustment
>+  ``DPLL_A_PIN_PHASE_ADJUST_MAX`` attr maximum value of phase adjustment
>+  ``DPLL_A_PIN_PHASE_ADJUST``     attr configured value of phase
>+                                  adjustment on parent dpll device
>+  ``DPLL_A_PIN_PARENT_DEVICE``    nested attribute for requesting
>+                                  configuration on given parent dpll
>+                                  device
>+    ``DPLL_A_PIN_PARENT_ID``      parent dpll device id
>+    ``DPLL_A_PIN_PHASE_OFFSET``   attr measured phase difference
>+                                  between a pin and parent dpll device
>+  =============================== ======================================
>+
>+All phase related values are provided in pico seconds, which represents
>+time differnece between signals phase. The negative value means that
>+phase of signal on pin is earlier in time than dpll's signal. Positive
>+value means that phase of signal on pin is later in time than signal of
>+a dpll.
>+
>+Phase adjust (also min and max) values are integers, but measured phase
>+offset values are fractional with 3-digit decimal places and shell be
>+divided with ``DPLL_PIN_PHASE_OFFSET_DIVIDER`` to get integer part and
>+modulo divided to get fractional part.
>+
> Configuration commands group
> ============================
> 
>@@ -263,6 +304,12 @@ according to attribute purpose.
>                                        frequencies
>       ``DPLL_A_PIN_ANY_FREQUENCY_MIN`` attr minimum value of frequency
>       ``DPLL_A_PIN_ANY_FREQUENCY_MAX`` attr maximum value of frequency
>+    ``DPLL_A_PIN_PHASE_ADJUST_MIN``    attr minimum value of phase
>+                                       adjustment
>+    ``DPLL_A_PIN_PHASE_ADJUST_MAX``    attr maximum value of phase
>+                                       adjustment
>+    ``DPLL_A_PIN_PHASE_ADJUST``        attr configured value of phase
>+                                       adjustment on parent device
>     ``DPLL_A_PIN_PARENT_DEVICE``       nested attr for each parent device
>                                        the pin is connected with
>       ``DPLL_A_PIN_PARENT_ID``         attr parent dpll device id
>@@ -270,8 +317,10 @@ according to attribute purpose.
>                                        dpll device
>       ``DPLL_A_PIN_STATE``             attr state of pin on the parent
>                                        dpll device
>-     ``DPLL_A_PIN_DIRECTION``          attr direction of a pin on the
>+      ``DPLL_A_PIN_DIRECTION``         attr direction of a pin on the

Could be in a separate patch, it's not related to this one.


>                                        parent dpll device
>+      ``DPLL_A_PIN_PHASE_OFFSET``      attr measured phase difference
>+                                       between a pin and parent dpll
>     ``DPLL_A_PIN_PARENT_PIN``          nested attr for each parent pin
>                                        the pin is connected with
>       ``DPLL_A_PIN_PARENT_ID``         attr parent pin id
>@@ -284,6 +333,8 @@ according to attribute purpose.
>   ``DPLL_CMD_PIN_SET``                 command to set pins configuration
>     ``DPLL_A_PIN_ID``                  attr unique a pin ID
>     ``DPLL_A_PIN_FREQUENCY``           attr requested frequency of a pin
>+    ``DPLL_A_PIN_PHASE_ADJUST``        attr requested value of phase
>+                                       adjustment on parent device
>     ``DPLL_A_PIN_PARENT_DEVICE``       nested attr for each parent dpll
>                                        device configuration request
>       ``DPLL_A_PIN_PARENT_ID``         attr parent dpll device id
>-- 
>2.38.1
>

