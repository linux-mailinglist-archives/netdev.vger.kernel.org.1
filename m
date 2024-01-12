Return-Path: <netdev+bounces-63262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A973482BFF8
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEB81F24ADD
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07A86A34B;
	Fri, 12 Jan 2024 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="D8oHWZ+a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729859B5C
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so4172008a12.2
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 04:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705063751; x=1705668551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdAL1zvj3PJjg4O7JY3bfPCKfGnZforu7n0vE87MDuk=;
        b=D8oHWZ+arIEIEzfh9XxfgHMz3g0kdveaqeqo1olqxD1L6tR+6XISyxgsuA+1dF2TDG
         0ZoJ/EiA8i6YZ8NZvZxO0HxBLND/vOVmqRJV/JdzuSRwCouIWvus0P1F0GGwCkeCP6YW
         QDcI4f81i/imLCSKlwyyEMLaN/qM81+T7u9wnW8b5SYW76k9FADi+DNz7WPqxyj16WAn
         QObJw3jE2V2wNEj7REQPuilHYs5/Y8Vd+RG1U9hpzCXF1bXkxVacaBj7pL3IadyIw2AR
         X7/IE2OPoYK3yZ3PmLixvAmiPVmWiKzjw14p8ykpWt683yAF6AaBuFlHQWYzEbEc5Azx
         9f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705063751; x=1705668551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdAL1zvj3PJjg4O7JY3bfPCKfGnZforu7n0vE87MDuk=;
        b=oZn0iscU4hsdQ3ZTomX5e9vSdetU6Iri7xtviXCU0+IR+2Zq+WYjPpizuzbMNoZ9tj
         3+UJA9Y9Ip4KIZphnK1IILy8i6T8Tg8KX17vCybx3MpebVMgPBBmyzamGaa7++QmnvU5
         xqJ99c//IOfTBzijWYfanD21p1noob/YpkSrDsHV9oXSWcc5jT9Cx5xrm2V4OyYw8IO9
         kwUJ7VnKZLxlN4dML7f1qcfnIPgj8F7Vcd59UPDj9O435lgYVK6HaYwtB96VLtPPb+6V
         cj4N0UiFMYdNDLUqqlnGXY3w9ncSN8xtVca/+XFwQSI9IVmPR3Xfl3JDppbExFUrYFZA
         uZGg==
X-Gm-Message-State: AOJu0YyDKcgXorfsRdsz/rz1CNOpS1dAyp65FGo20hBlDf+UUUTozcaL
	mvaL81uuyGR7xQUvJTEwka8NMfQAWQUABayyhkqvELOyJHc=
X-Google-Smtp-Source: AGHT+IG2PJyT+YYuGiK7VUFhWoSoaiD+o4PXnQRvazHmTSb9/opKtMvaHm+NYI2TrbYkMviuWKIB0Q==
X-Received: by 2002:a05:6402:5214:b0:558:c366:f010 with SMTP id s20-20020a056402521400b00558c366f010mr642520edd.24.1705063751364;
        Fri, 12 Jan 2024 04:49:11 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id fe7-20020a056402390700b0055668ccd9a3sm1754184edb.17.2024.01.12.04.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:49:10 -0800 (PST)
Date: Fri, 12 Jan 2024 13:49:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [PATCH iwl-next v1 2/2] i40e-linux: Add support for reading
 Trace Buffer
Message-ID: <ZaE1Ra8JQY4RoTTu@nanopsycho>
References: <20240112095945.450590-1-jedrzej.jagielski@intel.com>
 <20240112095945.450590-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112095945.450590-3-jedrzej.jagielski@intel.com>

Fri, Jan 12, 2024 at 10:59:45AM CET, jedrzej.jagielski@intel.com wrote:
>Currently after entering FW Recovery Mode we have no info in logs
>regarding current FW state.
>
>Add function reading content of the alternate RAM storing that info and
>print it into the log. Additionally print state of CSR register.
>
>Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
>Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>---
> drivers/net/ethernet/intel/i40e/i40e.h        |  2 ++
> drivers/net/ethernet/intel/i40e/i40e_main.c   | 35 +++++++++++++++++++
> .../net/ethernet/intel/i40e/i40e_register.h   |  2 ++
> drivers/net/ethernet/intel/i40e/i40e_type.h   |  5 +++
> 4 files changed, 44 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>index ba24f3fa92c3..6ebd2fd15e0e 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e.h
>+++ b/drivers/net/ethernet/intel/i40e/i40e.h
>@@ -23,6 +23,8 @@
> /* Useful i40e defaults */
> #define I40E_MAX_VEB			16
> 
>+#define I40_BYTES_PER_WORD		2
>+
> #define I40E_MAX_NUM_DESCRIPTORS	4096
> #define I40E_MAX_NUM_DESCRIPTORS_XL710	8160
> #define I40E_MAX_CSR_SPACE		(4 * 1024 * 1024 - 64 * 1024)
>diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>index 4977ff391fed..f5abe8c9a88d 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>@@ -15414,6 +15414,39 @@ static int i40e_handle_resets(struct i40e_pf *pf)
> 	return is_empr ? -EIO : pfr;
> }
> 
>+/**
>+ * i40e_log_fw_recovery_mode - log current FW state in Recovery Mode
>+ * @pf: board private structure
>+ *
>+ * Read alternate RAM and CSR registers and print them to the log
>+ **/
>+static void i40e_log_fw_recovery_mode(struct i40e_pf *pf)
>+{
>+	u8 buf[I40E_FW_STATE_BUFF_SIZE] = {0};
>+	struct i40e_hw *hw = &pf->hw;
>+	u8 fws0b, fws1b;
>+	u32 fwsts;
>+	int ret;
>+
>+	ret = i40e_aq_alternate_read_indirect(hw, I40E_ALT_CANARY,
>+					      I40E_ALT_BUFF_DWORD_SIZE, buf);
>+	if (ret) {
>+		dev_warn(&pf->pdev->dev,
>+			 "Cannot get FW trace buffer due to FW err %d aq_err %s\n",
>+			 ret, i40e_aq_str(hw, hw->aq.asq_last_status));
>+		return;
>+	}
>+
>+	fwsts = rd32(&pf->hw, I40E_GL_FWSTS);
>+	fws0b = FIELD_GET(I40E_GL_FWSTS_FWS0B_MASK, fwsts);
>+	fws1b = FIELD_GET(I40E_GL_FWSTS_FWS1B_MASK, fwsts);
>+
>+	print_hex_dump(KERN_DEBUG, "Trace Buffer: ", DUMP_PREFIX_NONE,
>+		       BITS_PER_BYTE * I40_BYTES_PER_WORD, 1, buf,
>+		       I40E_FW_STATE_BUFF_SIZE, true);

I don't follow. Why exactly you want to pollute dmesg with another
messages? Can't you use some other interface? Devlink health reporter
looks like a suitable alternative for this kind of operations.



>+	dev_dbg(&pf->pdev->dev, "FWS0B=0x%x, FWS1B=0x%x\n", fws0b, fws1b);
>+}
>+
> /**
>  * i40e_init_recovery_mode - initialize subsystems needed in recovery mode
>  * @pf: board private structure
>@@ -15497,6 +15530,8 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
> 	mod_timer(&pf->service_timer,
> 		  round_jiffies(jiffies + pf->service_timer_period));
> 
>+	i40e_log_fw_recovery_mode(pf);
>+
> 	return 0;
> 
> err_switch_setup:
>diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
>index 14ab642cafdb..8e254ff9c035 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
>+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
>@@ -169,6 +169,8 @@
> #define I40E_PRTDCB_TPFCTS_PFCTIMER_SHIFT 0
> #define I40E_PRTDCB_TPFCTS_PFCTIMER_MASK I40E_MASK(0x3FFF, I40E_PRTDCB_TPFCTS_PFCTIMER_SHIFT)
> #define I40E_GL_FWSTS 0x00083048 /* Reset: POR */
>+#define I40E_GL_FWSTS_FWS0B_SHIFT 0
>+#define I40E_GL_FWSTS_FWS0B_MASK  I40E_MASK(0xFF, I40E_GL_FWSTS_FWS0B_SHIFT)
> #define I40E_GL_FWSTS_FWS1B_SHIFT 16
> #define I40E_GL_FWSTS_FWS1B_MASK I40E_MASK(0xFF, I40E_GL_FWSTS_FWS1B_SHIFT)
> #define I40E_GL_FWSTS_FWS1B_EMPR_0 I40E_MASK(0x20, I40E_GL_FWSTS_FWS1B_SHIFT)
>diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
>index 725da7edbca3..0372a8d519ad 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
>+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
>@@ -1372,6 +1372,11 @@ struct i40e_lldp_variables {
> #define I40E_ALT_BW_VALUE_MASK		0xFF
> #define I40E_ALT_BW_VALID_MASK		0x80000000
> 
>+/* Alternate Ram Trace Buffer*/
>+#define I40E_ALT_CANARY				0xABCDEFAB
>+#define I40E_ALT_BUFF_DWORD_SIZE		0x14 /* in dwords */
>+#define I40E_FW_STATE_BUFF_SIZE			80
>+
> /* RSS Hash Table Size */
> #define I40E_PFQF_CTL_0_HASHLUTSIZE_512	0x00010000
> 
>-- 
>2.31.1
>
>

