Return-Path: <netdev+bounces-86772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53BC8A03CC
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 00:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBA11F2BA5B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C481D558;
	Wed, 10 Apr 2024 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="juenao2X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174712EB0B
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789695; cv=none; b=Xpvgtxio/OH26BsBhKNQPpmallJ2Cds30mcOu0e6q6E9R7PFLMuXfOlaLva0J9eW0o0aT2qjld03ZpmFMwE8uYgoV/X45fq8oo6BR7sXsSKzPuLBFlqTombajKfm31XICztoI9zqJICUBSgp5aXEJpD/u/1Au492BXh0RekMJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789695; c=relaxed/simple;
	bh=vs7M5q6ouuLvhcyHXeE7Ye1jF2YWAHHmN4evK/Df16Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UDXmN7+A+Tb2mu5gWHLHjuWvhoG6RoXsFsSv8KaJO3sKMPP5cBmhsfwmGqBdbdyDm/RvPKEfgfzRAsBk4f5ez499jfVaICdM4uc/BNClOetTxNUlQATSLH1jF4hQ1EFYIMC8GXkxV/YF7VgJi0q9LGil1Bo3JlsPl6qV1RdZ7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=juenao2X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712789692; x=1744325692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vs7M5q6ouuLvhcyHXeE7Ye1jF2YWAHHmN4evK/Df16Q=;
  b=juenao2Xk3R/XodwcUf73JGTpb6j2w/Xhv+nhiEBAjv8G2GGRLLGcC4f
   qK6Tk56eq3kbkaqNJ2Hd6PSVwdiJUGhfWWLc4vOPngqE7/biB44UwM5I3
   kRKMAXbSBnqCWAQTD/JsFkh8wy59RO5bAlH3F7WkA0o1CuH/C8k0qEHci
   g80XEkm/IfG0ivpYEikc4JyGtZfyxcNDL+Jp0Qh3NWErgPSAu+tmyJQaZ
   5xwzaVLDpObaTU9jZWqpkBOJMdKa7qxuiYQWgqdbT3dNCiamPWnCSGSaC
   zI+qMx2gRhMVpZoFjSht5pD1kcC7IVQSQWiGItLC6y+rIEFgFs8zWtMyx
   g==;
X-CSE-ConnectionGUID: W0m4E53SRimRC4pTPGfuhw==
X-CSE-MsgGUID: ubE7A36sSKKz2qgvkY5d5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25635917"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="25635917"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:54:52 -0700
X-CSE-ConnectionGUID: O/EG/ZquSCW7OnZVukZNkg==
X-CSE-MsgGUID: VKsSSPwGRvqtgbPCO+DOKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="51910859"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Apr 2024 15:54:50 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rugq7-0007uy-2p;
	Wed, 10 Apr 2024 22:54:47 +0000
Date: Thu, 11 Apr 2024 06:54:27 +0800
From: kernel test robot <lkp@intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [net:main 2/2] ERROR: modpost: "r8169_remove_leds"
 [drivers/net/ethernet/realtek/r8169.ko] undefined!
Message-ID: <202404110633.Li4X65Gb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git main
head:   19fa4f2a85d777a8052e869c1b892a2f7556569d
commit: 19fa4f2a85d777a8052e869c1b892a2f7556569d [2/2] r8169: fix LED-related deadlock on module removal
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240411/202404110633.Li4X65Gb-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240411/202404110633.Li4X65Gb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404110633.Li4X65Gb-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm64/crypto/crct10dif-ce.o
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm64/crypto/aes-neon-bs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/btrfs/btrfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/af_alg.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/ecc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/curve25519-generic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/xor.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libchacha.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libarc4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libdes.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx27.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-mediatek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-visconti.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek-gen3.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/qcom/lpass-gfm-sm8250.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/mediatek/mtk-cmdq-helper.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/qcom/spm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xen-pciback/xen-pciback.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611uxc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-slimbus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/fastrpc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-omap2-mcspi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/host/xhci-pci-renesas.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_acm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/u_serial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_serial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_obex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/u_ether.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ncm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ecm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_eem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ecm_subset.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_rndis.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_mass_storage.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_fs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/libcomposite.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/tuners/tda9887.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/rc-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/common/uvc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-fwnode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/edac/layerscape_edac_mod.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ufs/host/ufs-qcom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/coreboot_table.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/cbmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/crypto/sa2ul.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mailbox/mtk-cmdq-mailbox.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rpmsg/rpmsg_char.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/buffer/kfifo_buf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm-ccn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/fsl_imx8_ddr_perf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/arm_cspmu_module.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mm-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mq-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mn-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hte/hte-tegra194-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/fsl/imx-pcm-dma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/snd-soc-qcom-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/snd-soc-qcom-sdw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/qdsp6/snd-q6dsp-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/mediatek/mtk-adsp-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/mediatek/mt8195/snd-sof-mt8195.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/snd-sof-utils.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/sof/snd-sof-of.o
>> ERROR: modpost: "r8169_remove_leds" [drivers/net/ethernet/realtek/r8169.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

