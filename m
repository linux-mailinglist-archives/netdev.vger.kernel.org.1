Return-Path: <netdev+bounces-63539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F982DAEB
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CAD1C216BB
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC4D1757B;
	Mon, 15 Jan 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CQhfXKZW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382E15AD9
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e779f0253so8389415e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705327586; x=1705932386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7xm5T92TwJwkAFtHNJnBA6sJUJe8VuwE3qQUkc5mys=;
        b=CQhfXKZWVdg1oIeqpv8ch/93z7UE/1wB2lrZkPV249vKmv+kukpWWhEyLJ1OQbIxsb
         Yxybc5q8R7atH/txSToEpeCJ5fd4NJaZS8w1WAwLI+ZQ1OxKe8kV83CjrEHPhVu2dzFN
         FCs8WmMQdjObMWAPyBBEmNEWtdetumlGEZtEagO5/CZiFsbtz6op3UeSBsQzYK02mnxB
         m5EvdK7hN/FbXpMmbcMxltCLFR26/HLp7XDMtBfWnIdKsbcTw97eafYFsQAGUfAcLPeD
         AhHwbSZFGdV1hPgYCltHVQ++uagkJK6PflgPsWBW+b9a2pqWAfAucI3eeo3Zbg2V/xdj
         3tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705327586; x=1705932386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7xm5T92TwJwkAFtHNJnBA6sJUJe8VuwE3qQUkc5mys=;
        b=jOi5d3NOJdXisdlLG2g+CpDlm8gnEAeRqIGqJXY3FGsdp6v6w4xsXLm+ETcjnw2vIo
         PkFx+wgLcJIh6jyHIBJLs4KkNWHgeddhCf96NpcDSn8TGeeM0C/R9aSSXOW63H1SNpoS
         LRslS/fXPX7rcWvWrDDlabPnkxhEjtOi2injwjdhNz3k3wgr5aLOqcc8k1D83yuM/Kl3
         Gv4NYZtwe5eL+AgPah7V9lxdZfHU/SFnkZinShS+c1BUNwWWnUbH7Ih6NZE68Gt8ub27
         vN8ZDcy0p4D2dIjuyPocVceC8mKwwRStGqAchbVoTgoaHmB9pVvQ8x7fXGcI8x+uPsnu
         vJ/w==
X-Gm-Message-State: AOJu0YxAD6al7QIPBjsOqkzDzdXnFiFS+hmEpo0S3iehMSyiCnEJQDpK
	x5IAFc4Oy8FXPEMYT+MItbUitjZATLOjVP7525IjZ8dfMfWoQw==
X-Google-Smtp-Source: AGHT+IH4a2AeCRyzoh/vFxWnuozUa+H+1uYNl48MO0UapSJdeuXMDU7iiwGhNVSjvtELMKSp+hV5ag==
X-Received: by 2002:a05:600c:a01:b0:40e:4e48:513b with SMTP id z1-20020a05600c0a0100b0040e4e48513bmr3460222wmp.12.1705327586143;
        Mon, 15 Jan 2024 06:06:26 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e5945307esm16162290wmo.40.2024.01.15.06.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:06:25 -0800 (PST)
Date: Mon, 15 Jan 2024 15:06:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Sokolowski, Jan" <jan.sokolowski@intel.com>
Subject: Re: [PATCH iwl-next v1 2/2] i40e-linux: Add support for reading
 Trace Buffer
Message-ID: <ZaU73JvgApp_rAI3@nanopsycho>
References: <20240112095945.450590-1-jedrzej.jagielski@intel.com>
 <20240112095945.450590-3-jedrzej.jagielski@intel.com>
 <ZaE1Ra8JQY4RoTTu@nanopsycho>
 <DS0PR11MB77852D91C24051F70ECFBF7BF06C2@DS0PR11MB7785.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB77852D91C24051F70ECFBF7BF06C2@DS0PR11MB7785.namprd11.prod.outlook.com>

Mon, Jan 15, 2024 at 11:37:22AM CET, jedrzej.jagielski@intel.com wrote:
>From: Jiri Pirko <jiri@resnulli.us> 
>Sent: Friday, January 12, 2024 1:49 PM
>
>>Fri, Jan 12, 2024 at 10:59:45AM CET, jedrzej.jagielski@intel.com wrote:
>>>Currently after entering FW Recovery Mode we have no info in logs
>>>regarding current FW state.
>>>
>>>Add function reading content of the alternate RAM storing that info and
>>>print it into the log. Additionally print state of CSR register.
>>>
>>>Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
>>>Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>>---
>>> drivers/net/ethernet/intel/i40e/i40e.h        |  2 ++
>>> drivers/net/ethernet/intel/i40e/i40e_main.c   | 35 +++++++++++++++++++
>>> .../net/ethernet/intel/i40e/i40e_register.h   |  2 ++
>>> drivers/net/ethernet/intel/i40e/i40e_type.h   |  5 +++
>>> 4 files changed, 44 insertions(+)
>>>
>>>diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>>>index ba24f3fa92c3..6ebd2fd15e0e 100644
>>>--- a/drivers/net/ethernet/intel/i40e/i40e.h
>>>+++ b/drivers/net/ethernet/intel/i40e/i40e.h
>>>@@ -23,6 +23,8 @@
>>> /* Useful i40e defaults */
>>> #define I40E_MAX_VEB			16
>>> 
>>>+#define I40_BYTES_PER_WORD		2
>>>+
>>> #define I40E_MAX_NUM_DESCRIPTORS	4096
>>> #define I40E_MAX_NUM_DESCRIPTORS_XL710	8160
>>> #define I40E_MAX_CSR_SPACE		(4 * 1024 * 1024 - 64 * 1024)
>>>diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>>index 4977ff391fed..f5abe8c9a88d 100644
>>>--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>>>+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>>@@ -15414,6 +15414,39 @@ static int i40e_handle_resets(struct i40e_pf *pf)
>>> 	return is_empr ? -EIO : pfr;
>>> }
>>> 
>>>+/**
>>>+ * i40e_log_fw_recovery_mode - log current FW state in Recovery Mode
>>>+ * @pf: board private structure
>>>+ *
>>>+ * Read alternate RAM and CSR registers and print them to the log
>>>+ **/
>>>+static void i40e_log_fw_recovery_mode(struct i40e_pf *pf)
>>>+{
>>>+	u8 buf[I40E_FW_STATE_BUFF_SIZE] = {0};
>>>+	struct i40e_hw *hw = &pf->hw;
>>>+	u8 fws0b, fws1b;
>>>+	u32 fwsts;
>>>+	int ret;
>>>+
>>>+	ret = i40e_aq_alternate_read_indirect(hw, I40E_ALT_CANARY,
>>>+					      I40E_ALT_BUFF_DWORD_SIZE, buf);
>>>+	if (ret) {
>>>+		dev_warn(&pf->pdev->dev,
>>>+			 "Cannot get FW trace buffer due to FW err %d aq_err %s\n",
>>>+			 ret, i40e_aq_str(hw, hw->aq.asq_last_status));
>>>+		return;
>>>+	}
>>>+
>>>+	fwsts = rd32(&pf->hw, I40E_GL_FWSTS);
>>>+	fws0b = FIELD_GET(I40E_GL_FWSTS_FWS0B_MASK, fwsts);
>>>+	fws1b = FIELD_GET(I40E_GL_FWSTS_FWS1B_MASK, fwsts);
>>>+
>>>+	print_hex_dump(KERN_DEBUG, "Trace Buffer: ", DUMP_PREFIX_NONE,
>>>+		       BITS_PER_BYTE * I40_BYTES_PER_WORD, 1, buf,
>>>+		       I40E_FW_STATE_BUFF_SIZE, true);
>>
>>I don't follow. Why exactly you want to pollute dmesg with another
>>messages? Can't you use some other interface? Devlink health reporter
>>looks like a suitable alternative for this kind of operations.
>
>There is no devlink support for the i40e driver at this point.

So add it, what can I say...


>Dumping log in that case happen rather occasionally and debug log lvl is used
>so this should mitigate polluting the dmesg.

Nope, please don't put thing in logs when we have proper interfaces for
them.

pw-bot: cr


>
>>
>>
>>
>>>+	dev_dbg(&pf->pdev->dev, "FWS0B=0x%x, FWS1B=0x%x\n", fws0b, fws1b);
>>>+}
>>>+
>>> /**
>>>  * i40e_init_recovery_mode - initialize subsystems needed in recovery mode
>>>  * @pf: board private structure
>>>@@ -15497,6 +15530,8 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
>>> 	mod_timer(&pf->service_timer,
>>> 		  round_jiffies(jiffies + pf->service_timer_period));
>>> 
>>>+	i40e_log_fw_recovery_mode(pf);
>>>+
>>> 	return 0;
>>> 
>>> err_switch_setup:
>>>diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
>>>index 14ab642cafdb..8e254ff9c035 100644
>>>--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
>>>+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
>>>@@ -169,6 +169,8 @@
>>> #define I40E_PRTDCB_TPFCTS_PFCTIMER_SHIFT 0
>>> #define I40E_PRTDCB_TPFCTS_PFCTIMER_MASK I40E_MASK(0x3FFF, I40E_PRTDCB_TPFCTS_PFCTIMER_SHIFT)
>>> #define I40E_GL_FWSTS 0x00083048 /* Reset: POR */
>>>+#define I40E_GL_FWSTS_FWS0B_SHIFT 0
>>>+#define I40E_GL_FWSTS_FWS0B_MASK  I40E_MASK(0xFF, I40E_GL_FWSTS_FWS0B_SHIFT)
>>> #define I40E_GL_FWSTS_FWS1B_SHIFT 16
>>> #define I40E_GL_FWSTS_FWS1B_MASK I40E_MASK(0xFF, I40E_GL_FWSTS_FWS1B_SHIFT)
>>> #define I40E_GL_FWSTS_FWS1B_EMPR_0 I40E_MASK(0x20, I40E_GL_FWSTS_FWS1B_SHIFT)
>>>diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
>>>index 725da7edbca3..0372a8d519ad 100644
>>>--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
>>>+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
>>>@@ -1372,6 +1372,11 @@ struct i40e_lldp_variables {
>>> #define I40E_ALT_BW_VALUE_MASK		0xFF
>>> #define I40E_ALT_BW_VALID_MASK		0x80000000
>>> 
>>>+/* Alternate Ram Trace Buffer*/
>>>+#define I40E_ALT_CANARY				0xABCDEFAB
>>>+#define I40E_ALT_BUFF_DWORD_SIZE		0x14 /* in dwords */
>>>+#define I40E_FW_STATE_BUFF_SIZE			80
>>>+
>>> /* RSS Hash Table Size */
>>> #define I40E_PFQF_CTL_0_HASHLUTSIZE_512	0x00010000
>>> 
>>>-- 
>>>2.31.1
>>>
>>>

