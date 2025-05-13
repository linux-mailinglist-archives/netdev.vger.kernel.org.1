Return-Path: <netdev+bounces-190132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE47AB544E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F1D3AFBA4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0241428DEF8;
	Tue, 13 May 2025 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RpMImA/s"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181528DEE8;
	Tue, 13 May 2025 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138098; cv=none; b=LLn/GMbZjSPVDkkpZN46hrHXaeaYgPM0v9hrAAN78jx3nH3Zefkj6bOEVqvUK9B5Ar27vftr1Q0lk7DLXjZuMpRAcJHh8/UBNUvVcqS5EBv1TuMp1PmwNccBsQCChYute6HQJOPtx2gO4j9JxNPpSJIKgcThkate329Ire3VIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138098; c=relaxed/simple;
	bh=04IqMlrqp/WIYzuHaMiLU4ueA1GGHXFTtZcs+wvov0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys0Sz3h3KuRjcWfHxxHo6kVhowuhspoZ5+yzscxUz/hQR0MVJuADSZMSXLr06RRuv2kHkUgJ8m/jAPqcr3FMZk4OyRaVg43h9/Ahh+GG1rtRzP0JGmRtA/vh96wAcIQEs7dKz9M/1+Z6rOoX1NVxxizzGLhqIZhHQpIhxFCBvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RpMImA/s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N2H4cLPRbfUQFyPPzFfWWlyMCXtxohV6unCFbuukGGk=; b=RpMImA/s7eelZNYeI4DyjQj0Fu
	A2r8G1uC7Bd6Q6sDeo2MRR4pWhndq21tbRnwuMawpPDgcI1Z1mBIwK7hrMu2KVaGk6NSjkVpxbboO
	eREHDpiTLLp8fZv0L6WtuAblFXYoSIC/dv8OEGVhY9JLukEcEDsZVJOh/AMv1VuDWpyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEoQK-00CRpC-PS; Tue, 13 May 2025 14:07:52 +0200
Date: Tue, 13 May 2025 14:07:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: kernel test robot <lkp@intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [net-next PATCH v9 1/6] net: phy: pass PHY driver to
 .match_phy_device OP
Message-ID: <c097072b-af72-4d52-9f16-690b3ec3e75e@lunn.ch>
References: <20250511183933.3749017-2-ansuelsmth@gmail.com>
 <202505131337.ZjnU5fK1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505131337.ZjnU5fK1-lkp@intel.com>

On Tue, May 13, 2025 at 02:09:12PM +0800, kernel test robot wrote:
> Hi Christian,

Adding FUJITA Tomonori <fujita.tomonori@gmail.com>.


> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-pass-PHY-driver-to-match_phy_device-OP/20250512-024253
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250511183933.3749017-2-ansuelsmth%40gmail.com
> patch subject: [net-next PATCH v9 1/6] net: phy: pass PHY driver to .match_phy_device OP
> config: x86_64-randconfig-r073-20250513 (https://download.01.org/0day-ci/archive/20250513/202505131337.ZjnU5fK1-lkp@intel.com/config)
> compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
> rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505131337.ZjnU5fK1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505131337.ZjnU5fK1-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ***
>    *** Rust bindings generator 'bindgen' < 0.69.5 together with libclang >= 19.1
>    *** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),
>    *** unless patched (like Debian's).
>    ***   Your bindgen version:  0.65.1
>    ***   Your libclang version: 20.1.2
>    ***
>    ***
>    *** Please see Documentation/rust/quick-start.rst for details
>    *** on how to set up the Rust support.
>    ***
> >> error[E0308]: mismatched types
>    --> rust/kernel/net/phy.rs:527:18
>    |
>    527 |             Some(Adapter::<T>::match_phy_device_callback)
>    |             ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ incorrect number of function parameters
>    |             |
>    |             arguments to this enum variant are incorrect
>    |
>    = note: expected fn pointer `unsafe extern "C" fn(*mut bindings::phy_device, *const phy_driver) -> _`
>    found fn item `unsafe extern "C" fn(*mut bindings::phy_device) -> _ {phy::Adapter::<T>::match_phy_device_callback}`
>    help: the type constructed contains `unsafe extern "C" fn(*mut bindings::phy_device) -> i32 {phy::Adapter::<T>::match_phy_device_callback}` due to the type of the argument passed
>    --> rust/kernel/net/phy.rs:527:13
>    |
>    527 |             Some(Adapter::<T>::match_phy_device_callback)
>    |             ^^^^^---------------------------------------^
>    |                  |
>    |                  this argument influences the type of `Some`
>    note: tuple variant defined here
>    --> /opt/cross/rustc-1.78.0-bindgen-0.65.1/rustup/toolchains/1.78.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/option.rs:580:5
>    |
>    580 |     Some(#[stable(feature = "rust1", since = "1.0.0")] T),
>    |     ^^^^
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

