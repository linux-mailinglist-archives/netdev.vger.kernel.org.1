Return-Path: <netdev+bounces-46019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A937E0E3E
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 08:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDAB1C209C1
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 07:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D01C123;
	Sat,  4 Nov 2023 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bsoCE9Gp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28898487
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 07:53:56 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D419D
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 00:53:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso4562873a12.0
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699084431; x=1699689231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JbXr92Pi8AGmr0WtsYGhGPuUhIlcBsHJAnxWuTYabM=;
        b=bsoCE9GpvyeD5QxKOIwBdvZiISrquZjqEOyxgVy/LxDR0i75xpQV9Y/4eOlRwa7n+k
         mWwLDhI/yLeNRtpL9mDhPoLRRysWl//sZtYUKFxlmdxBIYgl5MRZUr/xviZ/P6vS3OF3
         xIgHsixmvQCvkY8EccJrcn9k0TmtnpIxCtipF3hgNJTSAuIuUHVa09U/xRDlaPUaJ+v9
         On42rW8pb5ZlZpq1Trb3BmvR5aGZAHeu2o9jgoeohlF9gkjKZdsVDb/zVYgldmtlFuPW
         JQrB1qO5NtTq/qXHuve/TnBwn/T8YRy5ZXhbRUYwrZjb0QDZku/yWKrKSlzOmIo7MSIW
         b2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699084431; x=1699689231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JbXr92Pi8AGmr0WtsYGhGPuUhIlcBsHJAnxWuTYabM=;
        b=LpVCUx7axdjKQnYzhgzS6bjJ6nbo4C3QrznZYZbPTb20Eq289Kq+b1fTBPtyCkFJbA
         PhUT2JeBuc5Uu/zGmy3eagY9WjltKxp3/6u0jucAxIXJvo+8L77C2LfMDKMUKOJMOkrS
         Y1Ss1p+v9m4jM0/lkjhuwKHpRx6mcQlya0ynV16zIrw6y5bzZFnDRe3M0Et+i/G346QJ
         +QDLSp8eVRGqlAtNo0c6TdPs3hqsGKWZx5iagoVE9pI6VL5MDz+xdcDf++1ierySxsyL
         L660gnEwMP4kg5hn1DLF905heFJkG4JnyT8+QB1BLQW/ba3dn4cqCjcW7KxGimLsuz2+
         qyWQ==
X-Gm-Message-State: AOJu0YwGZEbcAIxXAcj3waE/dZkdIllmVOANM11BTV5b0taiH7dXOGfy
	wU5s8Awo4PPtTd0jWCjdgyAi4g==
X-Google-Smtp-Source: AGHT+IHX69W8h4gSLV2o504mjpaAQKcKjheaX9JbuqNlL9QlJy0/NWDM5APsWNDVh+KfW/7ov1asoQ==
X-Received: by 2002:a05:6402:1049:b0:532:bf2a:8cbc with SMTP id e9-20020a056402104900b00532bf2a8cbcmr18392392edu.16.1699084430788;
        Sat, 04 Nov 2023 00:53:50 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c62-20020a509fc4000000b00540e894609dsm1854539edf.17.2023.11.04.00.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 00:53:48 -0700 (PDT)
Date: Sat, 4 Nov 2023 08:53:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Michalik, Michal" <michal.michalik@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, poros <poros@redhat.com>,
	"Olech, Milena" <milena.olech@intel.com>,
	mschmidt <mschmidt@redhat.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH RFC net-next v2 1/2] netdevsim: implement DPLL for
 subsystem selftests
Message-ID: <ZUX4ijwJv/karKpo@nanopsycho>
References: <20231030165326.24453-1-michal.michalik@intel.com>
 <20231030165326.24453-2-michal.michalik@intel.com>
 <ZUDeJiafjggGvLU/@nanopsycho>
 <CH3PR11MB8414DADABE61FF215E7F984CE3A5A@CH3PR11MB8414.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR11MB8414DADABE61FF215E7F984CE3A5A@CH3PR11MB8414.namprd11.prod.outlook.com>

Fri, Nov 03, 2023 at 06:45:25PM CET, michal.michalik@intel.com wrote:
>On 31 October 2023 12:00 PM CET, Jiri Pirko wrote:
>> 
>> Mon, Oct 30, 2023 at 05:53:25PM CET, michal.michalik@intel.com wrote:
>>>DPLL subsystem integration tests require a module which mimics the
>>>behavior of real driver which supports DPLL hardware. To fully test the
>>>subsystem the netdevsim is amended with DPLL implementation.
>>>
>>>Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>>>---
>>> drivers/net/Kconfig               |   1 +
>>> drivers/net/netdevsim/Makefile    |   2 +-
>>> drivers/net/netdevsim/dpll.c      | 438 ++++++++++++++++++++++++++++++++++++++
>>> drivers/net/netdevsim/dpll.h      |  81 +++++++
>>> drivers/net/netdevsim/netdev.c    |  20 ++
>>> drivers/net/netdevsim/netdevsim.h |   4 +
>>> 6 files changed, 545 insertions(+), 1 deletion(-)
>>> create mode 100644 drivers/net/netdevsim/dpll.c
>>> create mode 100644 drivers/net/netdevsim/dpll.h
>>>
>>>diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>>>index af0da4b..633ec89 100644
>>>--- a/drivers/net/Kconfig
>>>+++ b/drivers/net/Kconfig
>>>@@ -626,6 +626,7 @@ config NETDEVSIM
>>> 	depends on PSAMPLE || PSAMPLE=n
>>> 	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
>>> 	select NET_DEVLINK
>>>+	select DPLL
>>> 	help
>>> 	  This driver is a developer testing tool and software model that can
>>> 	  be used to test various control path networking APIs, especially
>>>diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makefile
>>>index f8de93b..f338ffb 100644
>>>--- a/drivers/net/netdevsim/Makefile
>>>+++ b/drivers/net/netdevsim/Makefile
>>>@@ -3,7 +3,7 @@
>>> obj-$(CONFIG_NETDEVSIM) += netdevsim.o
>>> 
>>> netdevsim-objs := \
>>>-	netdev.o dev.o ethtool.o fib.o bus.o health.o hwstats.o udp_tunnels.o
>>>+	netdev.o dev.o ethtool.o fib.o bus.o health.o hwstats.o udp_tunnels.o dpll.o
>>> 
>>> ifeq ($(CONFIG_BPF_SYSCALL),y)
>>> netdevsim-objs += \
>>>diff --git a/drivers/net/netdevsim/dpll.c b/drivers/net/netdevsim/dpll.c
>>>new file mode 100644
>>>index 0000000..050f68e
>>>--- /dev/null
>>>+++ b/drivers/net/netdevsim/dpll.c
>>>@@ -0,0 +1,438 @@
>>>+// SPDX-License-Identifier: GPL-2.0
>>>+/*
>>>+ * Copyright (c) 2023, Intel Corporation.
>>>+ * Author: Michal Michalik <michal.michalik@intel.com>
>>>+ */
>>>+#include "dpll.h"
>>>+
>>>+static struct dpll_pin_properties *
>>>+create_pin_properties(const char *label, enum dpll_pin_type type,
>> 
>> Please make sure to follow the namespace prefix notation in your patch
>> everywhere, functions, structs, defines.
>> "nsim_"
>> 
>
>Thanks - I overlooked that, will change.
>
>>>+		      unsigned long caps, u32 freq_supp_num, u64 fmin, u64 fmax)
>>>+{
>>>+	struct dpll_pin_frequency *freq_supp;
>>>+	struct dpll_pin_properties *pp;
>>>+
>>>+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
>>>+	if (!pp)
>>>+		return ERR_PTR(-ENOMEM);
>>>+
>>>+	freq_supp = kzalloc(sizeof(*freq_supp), GFP_KERNEL);
>>>+	if (!freq_supp)
>>>+		goto err;
>>>+	*freq_supp =
>>>+		(struct dpll_pin_frequency)DPLL_PIN_FREQUENCY_RANGE(fmin, fmax);
>> 
>> Drop the cast.

Then manage this differently without cast. Setter pelper perhaps? Figure
that out.


>> 
>
>Without the cast it does not compile.
>
>>>+
>>>+	pp->board_label = kasprintf(GFP_KERNEL, "%s_brd", label);
>>>+	pp->panel_label = kasprintf(GFP_KERNEL, "%s_pnl", label);
>>>+	pp->package_label = kasprintf(GFP_KERNEL, "%s_pcg", label);
>>>+	pp->freq_supported_num = freq_supp_num;
>>>+	pp->freq_supported = freq_supp;
>>>+	pp->capabilities = caps;
>>>+	pp->type = type;
>>>+
>>>+	return pp;
>>>+err:
>>>+	kfree(pp);
>>>+	return ERR_PTR(-ENOMEM);
>>>+}
>>>+
>>>+static struct dpll_pd *create_dpll_pd(int temperature, enum dpll_mode mode)
>>>+{
>>>+	struct dpll_pd *pd;
>>>+
>>>+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
>>>+	if (!pd)
>>>+		return ERR_PTR(-ENOMEM);
>>>+
>>>+	pd->temperature = temperature;
>>>+	pd->mode = mode;
>>>+
>>>+	return pd;
>>>+}
>>>+
>>>+static struct pin_pd *create_pin_pd(u64 frequency, u32 prio,
>>>+				    enum dpll_pin_direction direction)
>>>+{
>>>+	struct pin_pd *pd;
>>>+
>>>+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
>>>+	if (!pd)
>>>+		return ERR_PTR(-ENOMEM);
>>>+
>>>+	pd->state_dpll = DPLL_PIN_STATE_DISCONNECTED;
>>>+	pd->state_pin = DPLL_PIN_STATE_DISCONNECTED;
>>>+	pd->frequency = frequency;
>>>+	pd->direction = direction;
>>>+	pd->prio = prio;
>>>+
>>>+	return pd;
>>>+}
>>>+
>>>+static int
>>>+dds_ops_mode_get(const struct dpll_device *dpll, void *dpll_priv,
>>>+		 enum dpll_mode *mode, struct netlink_ext_ack *extack)
>>>+{
>>>+	*mode = ((struct dpll_pd *)(dpll_priv))->mode;
>> 
>> Please have variable assigned by dpll_priv instead of this.
>> Also, fix in the rest of the code.
>> 
>
>Please excuse me, I don't think I understand what you mean. Do you mean I should
>create a local variable struct dpll_pd and use it for assignment like that?
>	```
>	struct dpll_pd *pd = dpll_priv;
>	*mode = pd->mode;
>	```

Yes.


>
>>>+	return 0;
>>>+};
>>>+
>>>+static bool
>>>+dds_ops_mode_supported(const struct dpll_device *dpll, void *dpll_priv,
>>>+		       const enum dpll_mode mode,
>>>+		       struct netlink_ext_ack *extack)
>>>+{
>>>+	return true;
>>>+};
>>>+
>>>+static int
>>>+dds_ops_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
>>>+			enum dpll_lock_status *status,
>>>+			struct netlink_ext_ack *extack)
>>>+{
>>>+	if (((struct dpll_pd *)dpll_priv)->mode == DPLL_MODE_MANUAL)
>>>+		*status = DPLL_LOCK_STATUS_LOCKED;
>>>+	else
>>>+		*status = DPLL_LOCK_STATUS_UNLOCKED;
>> 
>> I don't understand the logic of this function. According to mode you
>> return if status is locked or not? For this, you should expose a debugfs
>> knob so the user can emulate changes of the HW.
>> 
>
>Assumption was, we are testing the API not trying to simulate the actual DPLL HW
>behavior. I was going for, the "simpler the better" principle. But since
>somebody else might want to use it differently and test more complex scenarios,
>I will add debugfs entries for this interaction.

Great.


>
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+dds_ops_temp_get(const struct dpll_device *dpll, void *dpll_priv, s32 *temp,
>>>+		 struct netlink_ext_ack *extack)
>>>+{
>>>+	*temp = ((struct dpll_pd *)dpll_priv)->temperature;
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+pin_frequency_set(const struct dpll_pin *pin, void *pin_priv,
>>>+		  const struct dpll_device *dpll, void *dpll_priv,
>>>+		  const u64 frequency, struct netlink_ext_ack *extack)
>>>+{
>>>+	((struct pin_pd *)pin_priv)->frequency = frequency;
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+pin_frequency_get(const struct dpll_pin *pin, void *pin_priv,
>>>+		  const struct dpll_device *dpll, void *dpll_priv,
>>>+		  u64 *frequency, struct netlink_ext_ack *extack)
>>>+{
>>>+	*frequency = ((struct pin_pd *)pin_priv)->frequency;
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+pin_direction_set(const struct dpll_pin *pin, void *pin_priv,
>>>+		  const struct dpll_device *dpll, void *dpll_priv,
>>>+		  const enum dpll_pin_direction direction,
>>>+		  struct netlink_ext_ack *extack)
>>>+{
>>>+	((struct pin_pd *)pin_priv)->direction = direction;
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+pin_direction_get(const struct dpll_pin *pin, void *pin_priv,
>>>+		  const struct dpll_device *dpll, void *dpll_priv,
>>>+		  enum dpll_pin_direction *direction,
>>>+		  struct netlink_ext_ack *extack)
>>>+{
>>>+	*direction = ((struct pin_pd *)pin_priv)->direction;
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+pin_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
>>>+		     const struct dpll_pin *parent_pin, void *parent_priv,
>>>+		     enum dpll_pin_state *state,
>>>+		     struct netlink_ext_ack *extack)
>>>+{
>>>+	*state = ((struct pin_pd *)pin_priv)->state_pin;
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+pin_state_on_dpll_get(const struct dpll_pin *pin, void *pin_priv,
>>>+		      const struct dpll_device *dpll, void *dpll_priv,
>>>+		      enum dpll_pin_state *state,
>>>+		      struct netlink_ext_ack *extack)
>>>+{
>>>+	*state = ((struct pin_pd *)pin_priv)->state_dpll;
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+pin_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
>>>+		     const struct dpll_pin *parent_pin, void *parent_priv,
>>>+		     const enum dpll_pin_state state,
>>>+		     struct netlink_ext_ack *extack)
>>>+{
>>>+	((struct pin_pd *)pin_priv)->state_pin = state;
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+pin_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>>>+		      const struct dpll_device *dpll, void *dpll_priv,
>>>+		      const enum dpll_pin_state state,
>>>+		      struct netlink_ext_ack *extack)
>>>+{
>>>+	((struct pin_pd *)pin_priv)->state_dpll = state;
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+pin_prio_get(const struct dpll_pin *pin, void *pin_priv,
>>>+	     const struct dpll_device *dpll, void *dpll_priv,
>>>+	     u32 *prio, struct netlink_ext_ack *extack)
>>>+{
>>>+	*prio = ((struct pin_pd *)pin_priv)->prio;
>>>+	return 0;
>>>+};
>>>+
>>>+static int
>>>+pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
>>>+	     const struct dpll_device *dpll, void *dpll_priv,
>>>+	     const u32 prio, struct netlink_ext_ack *extack)
>>>+{
>>>+	((struct pin_pd *)pin_priv)->prio = prio;
>>>+	return 0;
>>>+};
>>>+
>>>+static void
>>>+free_pin_properties(struct dpll_pin_properties *pp)
>>>+{
>>>+	if (pp) {
>> 
>> How exactly pp could be null?
>> 
>
>In normal circumstances it seems it cannot, I will remove the check.

Good.


>
>>>+		kfree(pp->board_label);
>>>+		kfree(pp->panel_label);
>>>+		kfree(pp->package_label);
>>>+		kfree(pp->freq_supported);
>>>+		kfree(pp);
>>>+	}
>>>+}
>>>+
>>>+static struct dpll_device_ops dds_ops = {
>>>+	.mode_get = dds_ops_mode_get,
>>>+	.mode_supported = dds_ops_mode_supported,
>>>+	.lock_status_get = dds_ops_lock_status_get,
>>>+	.temp_get = dds_ops_temp_get,
>>>+};
>>>+
>>>+static struct dpll_pin_ops pin_ops = {
>>>+	.frequency_set = pin_frequency_set,
>>>+	.frequency_get = pin_frequency_get,
>>>+	.direction_set = pin_direction_set,
>>>+	.direction_get = pin_direction_get,
>>>+	.state_on_pin_get = pin_state_on_pin_get,
>>>+	.state_on_dpll_get = pin_state_on_dpll_get,
>>>+	.state_on_pin_set = pin_state_on_pin_set,
>>>+	.state_on_dpll_set = pin_state_on_dpll_set,
>>>+	.prio_get = pin_prio_get,
>>>+	.prio_set = pin_prio_set,
>>>+};
>>>+
>>>+int nsim_dpll_init_owner(struct nsim_dpll_info *dpll, int devid)
>>>+{
>>>+	/* Create EEC DPLL */
>>>+	dpll->dpll_e = dpll_device_get(DPLLS_CLOCK_ID + devid, EEC_DPLL_DEV,
>> 
>> "#define DPLLS_CLOCK_ID 234"
>> 
>> You guys always come up with some funky way of making up ids and names.
>> Why this can't be randomly generated u64?
>> 
>
>As mentioned, "the simpler the better". Having it randomly generated implies
>need of exposing this randomly generated number to tests. Test need to be able
>unambiguously get this clock. But since I will be adding debugfs entries to
>change the lock state, I can also add one for returning clock id. I need that
>because I'm using more devices per one netdevsim module.

The test can easily get anything according to the pin associated with
netdevice. This is the entry point. Not only for tests, but also for any
dpll/synce app/daemon.



>
>>>+				       THIS_MODULE);
>>>+	if (IS_ERR(dpll->dpll_e))
>>>+		goto dpll_e;
>>>+	dpll->dpll_e_pd = create_dpll_pd(EEC_DPLL_TEMPERATURE,
>>>+					 DPLL_MODE_AUTOMATIC);
>>>+	if (IS_ERR(dpll->dpll_e))
>>>+		goto dpll_e_pd;
>>>+	if (dpll_device_register(dpll->dpll_e, DPLL_TYPE_EEC, &dds_ops,
>>>+				 (void *)dpll->dpll_e_pd))
>> 
>> Please avoid pointless casts. (void *) cast for arg of type (void *) are
>> especially pointless. Please make sure to fix this in the rest of the
>> code as well.
>> 
>
>Thanks, will do.
>
>>>+		goto e_reg;
>>>+
>>>+	/* Create PPS DPLL */
>>>+	dpll->dpll_p = dpll_device_get(DPLLS_CLOCK_ID + devid, PPS_DPLL_DEV,
>>>+				       THIS_MODULE);
>>>+	if (IS_ERR(dpll->dpll_p))
>>>+		goto dpll_p;
>>>+	dpll->dpll_p_pd = create_dpll_pd(PPS_DPLL_TEMPERATURE,
>>>+					 DPLL_MODE_MANUAL);
>>>+	if (IS_ERR(dpll->dpll_p_pd))
>>>+		goto dpll_p_pd;
>>>+	if (dpll_device_register(dpll->dpll_p, DPLL_TYPE_PPS, &dds_ops,
>> 
>> You always use "int err" to store the return value of function calls
>> returning 0/-EXXX like this one.
>> 
>
>Lesson learned, will fix.
>
>>>+				 (void *)dpll->dpll_p_pd))
>>>+		goto p_reg;
>>>+
>>>+	/* Create first pin (GNSS) */
>>>+	dpll->pp_gnss = create_pin_properties("GNSS", DPLL_PIN_TYPE_GNSS,
>>>+					      PIN_GNSS_CAPABILITIES,
>>>+					      1, DPLL_PIN_FREQUENCY_1_HZ,
>>>+					      DPLL_PIN_FREQUENCY_1_HZ);
>>>+	if (IS_ERR(dpll->pp_gnss))
>>>+		goto pp_gnss;
>>>+	dpll->p_gnss = dpll_pin_get(DPLLS_CLOCK_ID + devid, PIN_GNSS,
>>>+				    THIS_MODULE,
>>>+				    dpll->pp_gnss);
>>>+	if (IS_ERR(dpll->p_gnss))
>>>+		goto p_gnss;
>>>+	dpll->p_gnss_pd = create_pin_pd(DPLL_PIN_FREQUENCY_1_HZ,
>>>+					PIN_GNSS_PRIORITY,
>>>+					DPLL_PIN_DIRECTION_INPUT);
>>>+	if (IS_ERR(dpll->p_gnss_pd))
>>>+		goto p_gnss_pd;
>>>+	if (dpll_pin_register(dpll->dpll_e, dpll->p_gnss, &pin_ops,
>>>+			      (void *)dpll->p_gnss_pd))
>>>+		goto e_gnss_reg;
>>>+
>>>+	/* Create second pin (PPS) */
>>>+	dpll->pp_pps = create_pin_properties("PPS", DPLL_PIN_TYPE_EXT,
>>>+					     PIN_PPS_CAPABILITIES,
>>>+					     1, DPLL_PIN_FREQUENCY_1_HZ,
>>>+					     DPLL_PIN_FREQUENCY_1_HZ);
>>>+	if (IS_ERR(dpll->pp_pps))
>>>+		goto pp_pps;
>>>+	dpll->p_pps = dpll_pin_get(DPLLS_CLOCK_ID + devid, PIN_PPS, THIS_MODULE,
>>>+				   dpll->pp_pps);
>>>+	if (IS_ERR(dpll->p_pps))
>>>+		goto p_pps;
>>>+	dpll->p_pps_pd = create_pin_pd(DPLL_PIN_FREQUENCY_1_HZ,
>>>+				       PIN_PPS_PRIORITY,
>>>+				       DPLL_PIN_DIRECTION_INPUT);
>>>+	if (IS_ERR(dpll->p_pps_pd))
>>>+		goto p_pps_pd;
>>>+	if (dpll_pin_register(dpll->dpll_e, dpll->p_pps, &pin_ops,
>>>+			      (void *)dpll->p_pps_pd))
>>>+		goto e_pps_reg;
>>>+	if (dpll_pin_register(dpll->dpll_p, dpll->p_pps, &pin_ops,
>>>+			      (void *)dpll->p_pps_pd))
>>>+		goto p_pps_reg;
>>>+
>>>+	return 0;
>>>+
>>>+p_pps_reg:
>>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &pin_ops,
>>>+			    (void *)dpll->p_pps_pd);
>>>+e_pps_reg:
>>>+	kfree(dpll->p_pps_pd);
>>>+p_pps_pd:
>>>+	dpll_pin_put(dpll->p_pps);
>>>+p_pps:
>>>+	free_pin_properties(dpll->pp_pps);
>>>+pp_pps:
>>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &pin_ops,
>>>+			    (void *)dpll->p_gnss_pd);
>>>+e_gnss_reg:
>>>+	kfree(dpll->p_gnss_pd);
>>>+p_gnss_pd:
>>>+	dpll_pin_put(dpll->p_gnss);
>>>+p_gnss:
>>>+	free_pin_properties(dpll->pp_gnss);
>>>+pp_gnss:
>>>+	dpll_device_unregister(dpll->dpll_p, &dds_ops, (void *)dpll->dpll_p_pd);
>>>+p_reg:
>>>+	kfree(dpll->dpll_p_pd);
>>>+dpll_p_pd:
>>>+	dpll_device_put(dpll->dpll_p);
>>>+dpll_p:
>>>+	dpll_device_unregister(dpll->dpll_e, &dds_ops, (void *)dpll->dpll_e_pd);
>>>+e_reg:
>>>+	kfree(dpll->dpll_e_pd);
>>>+dpll_e_pd:
>>>+	dpll_device_put(dpll->dpll_e);
>>>+dpll_e:
>>>+	return -1;
>>>+}
>>>+
>>>+void nsim_dpll_free_owner(struct nsim_dpll_info *dpll)
>>>+{
>>>+	/* Free GNSS pin */
>>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &pin_ops,
>>>+			    (void *)dpll->p_gnss_pd);
>>>+	dpll_pin_put(dpll->p_gnss);
>>>+	free_pin_properties(dpll->pp_gnss);
>>>+	kfree(dpll->p_gnss_pd);
>>>+
>>>+	/* Free PPS pin */
>>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &pin_ops,
>>>+			    (void *)dpll->p_pps_pd);
>>>+	dpll_pin_unregister(dpll->dpll_p, dpll->p_pps, &pin_ops,
>>>+			    (void *)dpll->p_pps_pd);
>>>+	dpll_pin_put(dpll->p_pps);
>>>+	free_pin_properties(dpll->pp_pps);
>>>+	kfree(dpll->p_pps_pd);
>>>+
>>>+	/* Free DPLL EEC */
>>>+	dpll_device_unregister(dpll->dpll_e, &dds_ops, (void *)dpll->dpll_e_pd);
>>>+	dpll_device_put(dpll->dpll_e);
>>>+	kfree(dpll->dpll_e_pd);
>>>+
>>>+	/* Free DPLL PPS */
>>>+	dpll_device_unregister(dpll->dpll_p, &dds_ops, (void *)dpll->dpll_p_pd);
>>>+	dpll_device_put(dpll->dpll_p);
>>>+	kfree(dpll->dpll_p_pd);
>>>+}
>>>+
>>>+int nsim_rclk_init(struct nsim_dpll_info *dpll, int devid, unsigned int index)
>>>+{
>>>+	char *name = kasprintf(GFP_KERNEL, "RCLK_%i", index);
>>>+
>>>+	/* Get EEC DPLL */
>>>+	dpll->dpll_e = dpll_device_get(DPLLS_CLOCK_ID + devid, EEC_DPLL_DEV,
>>>+				       THIS_MODULE);
>>>+	if (IS_ERR(dpll->dpll_e))
>>>+		goto dpll;
>>>+
>>>+	/* Get PPS DPLL */
>>>+	dpll->dpll_p = dpll_device_get(DPLLS_CLOCK_ID + devid, PPS_DPLL_DEV,
>>>+				       THIS_MODULE);
>>>+	if (IS_ERR(dpll->dpll_p))
>>>+		goto dpll;
>>>+
>>>+	/* Create Recovered clock pin (RCLK) */
>>>+	dpll->pp_rclk = create_pin_properties(name,
>>>+					      DPLL_PIN_TYPE_SYNCE_ETH_PORT,
>>>+					      PIN_RCLK_CAPABILITIES, 1, 1e6,
>>>+					      125e6);
>>>+	if (IS_ERR(dpll->pp_rclk))
>>>+		goto dpll;
>>>+	dpll->p_rclk = dpll_pin_get(DPLLS_CLOCK_ID + devid, PIN_RCLK + index,
>>>+				    THIS_MODULE, dpll->pp_rclk);
>>>+	if (IS_ERR(dpll->p_rclk))
>>>+		goto p_rclk;
>>>+	dpll->p_rclk_pd = create_pin_pd(DPLL_PIN_FREQUENCY_10_MHZ,
>>>+					PIN_RCLK_PRIORITY,
>>>+					DPLL_PIN_DIRECTION_INPUT);
>>>+	if (IS_ERR(dpll->p_rclk_pd))
>>>+		goto p_rclk_pd;
>>>+	if (dpll_pin_register(dpll->dpll_e, dpll->p_rclk, &pin_ops,
>>>+			      (void *)dpll->p_rclk_pd))
>>>+		goto dpll_e_reg;
>>>+	if (dpll_pin_register(dpll->dpll_p, dpll->p_rclk, &pin_ops,
>>>+			      (void *)dpll->p_rclk_pd))
>>>+		goto dpll_p_reg;
>>>+
>>>+	return 0;
>>>+
>>>+dpll_p_reg:
>>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_rclk, &pin_ops,
>>>+			    (void *)dpll->p_rclk_pd);
>>>+dpll_e_reg:
>>>+	kfree(dpll->p_rclk_pd);
>>>+p_rclk_pd:
>>>+	dpll_pin_put(dpll->p_rclk);
>>>+p_rclk:
>>>+	free_pin_properties(dpll->pp_rclk);
>>>+dpll:
>>>+	return -1;
>>>+}
>>>+
>>>+void nsim_rclk_free(struct nsim_dpll_info *dpll)
>>>+{
>>>+	/* Free RCLK pin */
>>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_rclk, &pin_ops,
>>>+			    (void *)dpll->p_rclk_pd);
>>>+	dpll_pin_unregister(dpll->dpll_p, dpll->p_rclk, &pin_ops,
>>>+			    (void *)dpll->p_rclk_pd);
>>>+	dpll_pin_put(dpll->p_rclk);
>>>+	free_pin_properties(dpll->pp_rclk);
>>>+	kfree(dpll->p_rclk_pd);
>>>+	dpll_device_put(dpll->dpll_e);
>>>+	dpll_device_put(dpll->dpll_p);
>>>+}
>>>diff --git a/drivers/net/netdevsim/dpll.h b/drivers/net/netdevsim/dpll.h
>>>new file mode 100644
>>>index 0000000..17db7f7
>>>--- /dev/null
>>>+++ b/drivers/net/netdevsim/dpll.h
>>>@@ -0,0 +1,81 @@
>>>+/* SPDX-License-Identifier: GPL-2.0 */
>>>+/*
>>>+ * Copyright (c) 2023, Intel Corporation.
>>>+ * Author: Michal Michalik <michal.michalik@intel.com>
>>>+ */
>>>+
>>>+#ifndef NSIM_DPLL_H
>>>+#define NSIM_DPLL_H
>> 
>> Why you need a separate header for this? Just put necessary parts in
>> netdevsim.h and leave the rest in the .c file.
>> 
>
>Good idea, thanks.
>
>>>+
>>>+#include <linux/types.h>
>>>+#include <linux/netlink.h>
>>>+
>>>+#include <linux/dpll.h>
>>>+#include <uapi/linux/dpll.h>
>> 
>> Why exactly do you need to include uapi header directly?
>> 
>
>You are right - will refactor that.
>
>>>+
>>>+#define EEC_DPLL_DEV 0
>>>+#define EEC_DPLL_TEMPERATURE 20
>>>+#define PPS_DPLL_DEV 1
>>>+#define PPS_DPLL_TEMPERATURE 30
>>>+#define DPLLS_CLOCK_ID 234
>>>+
>>>+#define PIN_GNSS 0
>>>+#define PIN_GNSS_CAPABILITIES 2 /* DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE */
>>>+#define PIN_GNSS_PRIORITY 5
>>>+
>>>+#define PIN_PPS 1
>>>+#define PIN_PPS_CAPABILITIES 7 /* DPLL_PIN_CAPS_DIRECTION_CAN_CHANGE
>>>+				* || DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE
>>>+				* || DPLL_PIN_CAPS_STATE_CAN_CHANGE
>> 
>> You are kidding, correct? :)
>> 
>
>Not really, it's written directly because the tests are able to read the value
>from here (they don't understand DPLL subsystem defines). Since we are changing
>most of the code I will try to make the tests access this data differently (e.g.
>via debugfs).

The test is reading define value from header file? Why on earth? :)



>
>>>+				*/
>>>+#define PIN_PPS_PRIORITY 6
>>>+
>>>+#define PIN_RCLK 2
>>>+#define PIN_RCLK_CAPABILITIES 6 /* DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE
>>>+				 * || DPLL_PIN_CAPS_STATE_CAN_CHANGE
>>>+				 */
>>>+#define PIN_RCLK_PRIORITY 7
>>>+
>>>+#define EEC_PINS_NUMBER 3
>>>+#define PPS_PINS_NUMBER 2
>>>+
>>>+struct dpll_pd {
>> 
>> Have not clue what do you mean by "pd".
>> 
>
>I meant "private data", will change this to something more meaningful.

Cool. Don't forget the nsim prefix.


>
>>>+	enum dpll_mode mode;
>>>+	int temperature;
>>>+};
>>>+
>>>+struct pin_pd {
>>>+	u64 frequency;
>>>+	enum dpll_pin_direction direction;
>>>+	enum dpll_pin_state state_pin;
>>>+	enum dpll_pin_state state_dpll;
>>>+	u32 prio;
>>>+};
>>>+
>>>+struct nsim_dpll_info {
>> 
>> Drop "info".
>> 
>
>OK.
>
>>>+	bool owner;
>>>+
>>>+	struct dpll_device *dpll_e;
>>>+	struct dpll_pd *dpll_e_pd;
>>>+	struct dpll_device *dpll_p;
>>>+	struct dpll_pd *dpll_p_pd;
>>>+
>>>+	struct dpll_pin_properties *pp_gnss;
>> 
>> Why pointer? Just embed the properties struct, no?
>> 
>
>I can change both private data and properties to be embeded.

Great.


>
>>>+	struct dpll_pin *p_gnss;
>>>+	struct pin_pd *p_gnss_pd;
>>>+
>>>+	struct dpll_pin_properties *pp_pps;
>>>+	struct dpll_pin *p_pps;
>>>+	struct pin_pd *p_pps_pd;
>>>+
>>>+	struct dpll_pin_properties *pp_rclk;
>>>+	struct dpll_pin *p_rclk;
>>>+	struct pin_pd *p_rclk_pd;
>>>+};
>>>+
>>>+int nsim_dpll_init_owner(struct nsim_dpll_info *dpll, int devid);
>>>+void nsim_dpll_free_owner(struct nsim_dpll_info *dpll);
>>>+int nsim_rclk_init(struct nsim_dpll_info *dpll, int devid, unsigned int index);
>>>+void nsim_rclk_free(struct nsim_dpll_info *dpll);
>>>+
>>>+#endif /* NSIM_DPLL_H */
>>>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>>index aecaf5f..78a936f 100644
>>>--- a/drivers/net/netdevsim/netdev.c
>>>+++ b/drivers/net/netdevsim/netdev.c
>>>@@ -25,6 +25,7 @@
>>> #include <net/udp_tunnel.h>
>>> 
>>> #include "netdevsim.h"
>>>+#include "dpll.h"
>>> 
>>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>> {
>>>@@ -344,6 +345,20 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>>> 	if (err)
>>> 		goto err_ipsec_teardown;
>>> 	rtnl_unlock();
>>>+
>>>+	if (ns->nsim_dev_port->port_index == 0) {
>> 
>> Does not make any sense to treat port 0 any different.
>> 
>> Please, move the init of dpll device to drivers/net/netdevsim/dev.c
>> probably somewhere in nsim_drv_probe().
>> 
>
>Great idea - I will do it.
>
>>>+		err = nsim_dpll_init_owner(&ns->dpll,
>>>+					   ns->nsim_dev->nsim_bus_dev->dev.id);
>>>+		if (err)
>>>+			goto err_ipsec_teardown;
>>>+	}
>>>+
>>>+	err = nsim_rclk_init(&ns->dpll, ns->nsim_dev->nsim_bus_dev->dev.id,
>>>+			     ns->nsim_dev_port->port_index);
>> 
>> This is not related to netdev directly. Please move the pin init into
>> drivers/net/netdevsim/dev.c, probably somewhere inside
>> __nsim_dev_port_add()
>> 
>> Also, you don't call netdev_dpll_pin_set() and netdev_dpll_pin_clear().
>> That is actually what you should call here in netdev initialization.
>> 
>
>Good catch - I will move to dev.c and use netdev_dpll_pin_set/clear()

Cool.


>
>>>+
>>>+	if (err)
>>>+		goto err_ipsec_teardown;
>>>+
>>> 	return 0;
>>> 
>>> err_ipsec_teardown:
>>>@@ -419,6 +434,11 @@ void nsim_destroy(struct netdevsim *ns)
>>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
>>> 		nsim_udp_tunnels_info_destroy(dev);
>>> 	mock_phc_destroy(ns->phc);
>>>+
>>>+	nsim_rclk_free(&ns->dpll);
>>>+	if (ns->nsim_dev_port->port_index == 0)
>>>+		nsim_dpll_free_owner(&ns->dpll);
>>>+
>>> 	free_netdev(dev);
>>> }
>>> 
>>>diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>>>index 028c825..3d0138a 100644
>>>--- a/drivers/net/netdevsim/netdevsim.h
>>>+++ b/drivers/net/netdevsim/netdevsim.h
>>>@@ -26,6 +26,8 @@
>>> #include <net/xdp.h>
>>> #include <net/macsec.h>
>>> 
>>>+#include "dpll.h"
>>>+
>>> #define DRV_NAME	"netdevsim"
>>> 
>>> #define NSIM_XDP_MAX_MTU	4000
>>>@@ -125,6 +127,8 @@ struct netdevsim {
>>> 	} udp_ports;
>>> 
>>> 	struct nsim_ethtool ethtool;
>>>+
>>>+	struct nsim_dpll_info dpll;
>>> };
>>> 
>>> struct netdevsim *
>>>-- 
>>>2.9.5
>>>
>

