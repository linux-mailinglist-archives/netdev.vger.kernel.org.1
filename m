Return-Path: <netdev+bounces-140663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC49B778D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7AC1C22086
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2B19341D;
	Thu, 31 Oct 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z4utpWuL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E5131BDD;
	Thu, 31 Oct 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367091; cv=none; b=XniyKoB7BsFjpA0PqvkByx2yj8C44lHnoi+ooNG/12AHtuVACtVUFtV1KPotrR5X06RWXDvx2rZpCN8l0KzpMnKNvWzU6pLvMyt0OLwn5a5IhxSjijfVHN4E7XbuFHFZNfN8dJUwJFJX/8AjFO7QyzlaDdxI4eH+AWlCD6cNRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367091; c=relaxed/simple;
	bh=M7n9ArN1pF/j++L+7rpatjFM0gfuXP/agcXResfeXIw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwiNhKxM3dfKlG5HOpPjcisiNuGN327LDTR4x6He6qk1OGg6jTiJ+0B5MAAi3n8DoXcT8rf7jZEcPADhplnP/A/+l6HFGYwYoSytT3mQPw4ZsK55Sr4sWdPtDLGiH6u2BI9q52ObvivkjFVL15tLxiOcsl0i7qPxvBiyRAZ3pdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z4utpWuL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730367088; x=1761903088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M7n9ArN1pF/j++L+7rpatjFM0gfuXP/agcXResfeXIw=;
  b=Z4utpWuLk7p8JdYp16lZM29QZshlIVz5vMUVXMo8R51fhri+D+QQ1GTD
   jYl/iRUB3rAk+yq3G33S+SDcy4ARqzD2sjVs7fPK1+NaPpsa0QboMilLl
   uFml84Zx+IBHGqX0UBk+7MKhiC+08KRnF7iI6+KkZkvP+8j98qsKtqO8k
   EMWtpwoh+0U+d6zkjkhjPuTapM6hhxCA/mkGEm5DTfx3HmkLZ9LXXhitz
   LqvYyAY+vv7qg23d3S1+vjWMC+hHCQHI6QrwH+loZbgdLPeykcH2Fu+ca
   ctidWQc7phhJFbS6xXVm2lS2OTfdaH/cdvxTbZRPU6yvldjhbj1lh4igS
   A==;
X-CSE-ConnectionGUID: 49pURKPtTNqTvY80gZRRCQ==
X-CSE-MsgGUID: KxhHOITaRC6Jo4IAeI9sKA==
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="201138544"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2024 02:31:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 31 Oct 2024 02:30:57 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 31 Oct 2024 02:30:55 -0700
Date: Thu, 31 Oct 2024 09:30:54 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 0/9] lib: packing: introduce and use
 (un)pack_fields
Message-ID: <20241031093054.p5gz2defkbytsjcx@DEN-DL-M70577>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>

> This series improves the packing library with a new API for packing or
> unpacking a large number of fields at once with minimal code footprint. The
> API is then used to replace bespoke packing logic in the ice driver,
> preparing it to handle unpacking in the future. Finally, the ice driver has
> a few other cleanups related to the packing logic.
> 
> The pack_fields and unpack_fields functions have the following improvements
> over the existing pack() and unpack() API:
> 
>  1. Packing or unpacking a large number of fields takes significantly less
>     code. This significantly reduces the .text size for an increase in the
>     .data size which is much smaller.
> 
>  2. The unpacked data can be stored in sizes smaller than u64 variables.
>     This reduces the storage requirement both for runtime data structures,
>     and for the rodata defining the fields. This scales with the number of
>     fields used.
> 
>  3. Most of the error checking is done at compile time, rather than
>     runtime via CHECK_PACKED_FIELD_* macros. This saves wasted computation
>     time, *and* catches errors in the field definitions immediately instead
>     of only after the offending code executes.
> 
> The actual packing and unpacking code still uses the u64 size
> variables. However, these are converted to the appropriate field sizes when
> storing or reading the data from the buffer.
> 
> One complexity is that the CHECK_PACKED_FIELD_* macros need to be defined
> one per size of the packed_fields array. This is because we don't have a
> good way to handle the ordering checks otherwise. The C pre-processor is
> unable to generate and run variable length loops at compile time.
> 
> This is a significant amount of macro code, ~22,000 lines of code. To
> ensure it is correct and to avoid needing to store this directly in the
> kernel history, this file is generated as <generated/packing-checks.h> via
> a small C program, gen_packing_checks. To generate this, we need to update
> the top level Kbuild process to include the compilation of
> gen_packing_checks and execution to generate the packing-checks.h file.
> 

Hi Jacob,

As for the rest of the patches:

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

I can confirm that smatch does not complain anymore, after Dan's recent
commit that skips the macros.

/Daniel


