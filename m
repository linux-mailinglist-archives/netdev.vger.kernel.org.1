Return-Path: <netdev+bounces-61555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA17824419
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EE7285940
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB723752;
	Thu,  4 Jan 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vp5UZ9je"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF223747
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so608660e87.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704379663; x=1704984463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfVBwkOH/qOR6M4rih0KUy+5jfSd6PJn/IuBN+59/14=;
        b=Vp5UZ9jewAMkEFG0sQjvEec8pAXOILvnVAYwWiIChSijzDXN+oURtpAEGWqQ7W1/lI
         nX7m0PiPpFEI9/xymXkdEmaMs4AUDbtebgg72Zqm84YGiYUqIDA6cyC7h7xB21axOV0T
         lha9gvwqBcfh8Uq9muJH4VNlXu9T5aXPI1yDzUSzMmVGDaiZu7bxXVksz+HhFAVFHbQj
         djXDTiRBKvyDrVYZ8MJwpKtGwwt6hgEolWGCLc1MtXnxJTJB8KPRg+9OrIRK2B4rxzWg
         4bWFitl+nALOMsnn0TkqDo9vhMCVEFXIzwteHcan49Bx2kCVXl1IJvS0VSVMF2heT0c4
         abJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704379663; x=1704984463;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfVBwkOH/qOR6M4rih0KUy+5jfSd6PJn/IuBN+59/14=;
        b=TbvOZCUuoFZxJyQd6D2S3YTEzWKr8ssTbfrnbXYAApFPTp477X2cngA6vExwZshZkq
         4WXelvhyo6fisyurSNFXNp1jLa9oac/IgdBWu03Exh8NVAdQsjxBL0CdiRN7SRT3OC0F
         JR05BBZHYnbS8gCKR1m6qb183fbv+YtgVG0swMe6Qq1v5QldPAmxof+HwTkOm08XPp2p
         oEMkS9z4fVnwH4j1yi7z48IZ9uSCpIMr79bW1iFMMotS2dXQDWqjr6tWRjvioQSJaKWh
         B8EbFin82RCip7KvirM2Z+FzdHSUtCU2KliZ1Sj93n8dTzvrVyoRn6oafGHCJrl7pTaf
         RdlQ==
X-Gm-Message-State: AOJu0YwIhdAwCZwtfNEJcW6woJZiBI7KZtVueddwxt2mpbQE38XWB1hv
	F3Uov2hLcPDrQWDkehIYPeneFAjUV+WUYg==
X-Google-Smtp-Source: AGHT+IF117QXnpuvzxN4k7ZWFQU+WS2Vnv3gcLBVFPn+SbU8WR2VxRUpgBrqVdYwYz6vf0xwXjJxXQ==
X-Received: by 2002:a05:6512:ba8:b0:50e:7be3:d325 with SMTP id b40-20020a0565120ba800b0050e7be3d325mr458204lfv.86.1704379663433;
        Thu, 04 Jan 2024 06:47:43 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id x7-20020a50ba87000000b005527cfaa2dfsm19534526ede.49.2024.01.04.06.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:47:42 -0800 (PST)
Date: Thu, 4 Jan 2024 17:47:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next v1] ixgbe: Convert ret val type from s32 to int
Message-ID: <08d8b75e-af80-438b-8006-9121b8444f49@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103101135.386891-1-jedrzej.jagielski@intel.com>

Hi Jedrzej,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jedrzej-Jagielski/ixgbe-Convert-ret-val-type-from-s32-to-int/20240103-182213
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
patch link:    https://lore.kernel.org/r/20240103101135.386891-1-jedrzej.jagielski%40intel.com
patch subject: [PATCH iwl-next v1] ixgbe: Convert ret val type from s32 to int
config: i386-randconfig-141-20240104 (https://download.01.org/0day-ci/archive/20240104/202401041701.6QKTsZmx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202401041701.6QKTsZmx-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2884 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3130 ixgbe_enter_lplu_t_x550em() warn: missing error code? 'status'

Old smatch warnings:
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2890 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'

vim +/status +2884 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c

9ea222bfe41f87 Jedrzej Jagielski 2024-01-03  2866  static int ixgbe_get_lcd_t_x550em(struct ixgbe_hw *hw,
6ac7439459606a Don Skidmore      2015-06-17  2867  				  ixgbe_link_speed *lcd_speed)
6ac7439459606a Don Skidmore      2015-06-17  2868  {
6ac7439459606a Don Skidmore      2015-06-17  2869  	u16 an_lp_status;
9ea222bfe41f87 Jedrzej Jagielski 2024-01-03  2870  	int status;
6ac7439459606a Don Skidmore      2015-06-17  2871  	u16 word = hw->eeprom.ctrl_word_3;
6ac7439459606a Don Skidmore      2015-06-17  2872  
6ac7439459606a Don Skidmore      2015-06-17  2873  	*lcd_speed = IXGBE_LINK_SPEED_UNKNOWN;
6ac7439459606a Don Skidmore      2015-06-17  2874  
6ac7439459606a Don Skidmore      2015-06-17  2875  	status = hw->phy.ops.read_reg(hw, IXGBE_AUTO_NEG_LP_STATUS,
4dc4000b35119f Emil Tantilov     2016-09-26  2876  				      MDIO_MMD_AN,
6ac7439459606a Don Skidmore      2015-06-17  2877  				      &an_lp_status);
6ac7439459606a Don Skidmore      2015-06-17  2878  	if (status)
6ac7439459606a Don Skidmore      2015-06-17  2879  		return status;
6ac7439459606a Don Skidmore      2015-06-17  2880  
6ac7439459606a Don Skidmore      2015-06-17  2881  	/* If link partner advertised 1G, return 1G */
6ac7439459606a Don Skidmore      2015-06-17  2882  	if (an_lp_status & IXGBE_AUTO_NEG_LP_1000BASE_CAP) {
6ac7439459606a Don Skidmore      2015-06-17  2883  		*lcd_speed = IXGBE_LINK_SPEED_1GB_FULL;
6ac7439459606a Don Skidmore      2015-06-17 @2884  		return status;

Smatch only warns about missing error codes when the function returns an
int.  :P  The bug predates your patch obvoiusly.

6ac7439459606a Don Skidmore      2015-06-17  2885  	}
6ac7439459606a Don Skidmore      2015-06-17  2886  
6ac7439459606a Don Skidmore      2015-06-17  2887  	/* If 10G disabled for LPLU via NVM D10GMP, then return no valid LCD */
6ac7439459606a Don Skidmore      2015-06-17  2888  	if ((hw->bus.lan_id && (word & NVM_INIT_CTRL_3_D10GMP_PORT1)) ||
6ac7439459606a Don Skidmore      2015-06-17  2889  	    (word & NVM_INIT_CTRL_3_D10GMP_PORT0))
6ac7439459606a Don Skidmore      2015-06-17  2890  		return status;
6ac7439459606a Don Skidmore      2015-06-17  2891  
6ac7439459606a Don Skidmore      2015-06-17  2892  	/* Link partner not capable of lower speeds, return 10G */
6ac7439459606a Don Skidmore      2015-06-17  2893  	*lcd_speed = IXGBE_LINK_SPEED_10GB_FULL;
6ac7439459606a Don Skidmore      2015-06-17  2894  	return status;
6ac7439459606a Don Skidmore      2015-06-17  2895  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


