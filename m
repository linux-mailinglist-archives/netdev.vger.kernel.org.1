Return-Path: <netdev+bounces-228155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F501BC2F86
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 01:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1535D3A9EC7
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 23:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5DB246BC6;
	Tue,  7 Oct 2025 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPXDaRlk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D1189B80;
	Tue,  7 Oct 2025 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880508; cv=none; b=FVKFwzewOQ6A/BsO7KEaQTQQeWx9vILEveCJ1SQ4Ao01zfDWzEegJuEKsI1ZMXHzlGK6zaof0tvzpn1rgY8L0nRMCUAIjIW8p0hbrM0Tsrsqin7kQWwja/LU9SgefxADNATbgTydgtHEHkV2mvTeEMtFSo1L88+qnl/jdGz76Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880508; c=relaxed/simple;
	bh=1cnsd+uVX0rUVnRBjaxDPmGWBksgCmzksWylM0s99T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFBkXKykRHuOImTLfCjnaMJyI3CYDTdpEeKyMS8z6lNceeAvBAwNmOQeguqke0r2eRzrex7dJzO3NLehcEZ4hVDj7RQV4LCSwQqKPpnRePHL33AeUzwBRrv5Pipi/z8x4wyUjTZg9zrJBbQD+609OWDb4SOpjs8d7Dxb7WjubRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPXDaRlk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759880506; x=1791416506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1cnsd+uVX0rUVnRBjaxDPmGWBksgCmzksWylM0s99T8=;
  b=OPXDaRlkp5+9nVkuDcPyJuwxeR13dDQ6pz0+z+tY2CxLAAFZx4TYBNSK
   c5jt/z0AROgVQx7eqKfsHinA9R8u4OYHKJwRZU9V5d6QLUoJ83JKmlCFA
   UD+2lSsuRrzERrrbrti5fkCnvrEK9r21oF0NdbCG8HTdvcxCHdJqQdABC
   +1baR/ODOJOTnyizXvPe/kZ7t5NqJl1aDHcu+rsJXmZofzKrVxWH1GqZg
   y5TxgQkh51ba2APcCphm/YmSdXWca+E5ATnbYeFVwBphx9EmnEeL1VqPH
   wS7dSl1crFZRtSVGT1+6aCxMRVobh9PSgk5enE2dnCNWougdwb26pLxvH
   g==;
X-CSE-ConnectionGUID: ozPG14xVQVaBgbrCi4JyFw==
X-CSE-MsgGUID: dPBhsfMsRue2hVKbM0C+UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62105941"
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="62105941"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 16:41:46 -0700
X-CSE-ConnectionGUID: 9DLGXCLISLCTAdyxE1r5xA==
X-CSE-MsgGUID: pTsKhEWzSL6EkPQwHE/LBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="179960881"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.156]) ([10.125.110.156])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 16:41:44 -0700
Message-ID: <ecef9be4-79cc-4951-bbc4-807869ba1fd5@intel.com>
Date: Tue, 7 Oct 2025 16:41:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/22] Type2 device basic support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/6/25 3:01 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> The patchset should be applied on the described base commit then applying
> Terry's v11 about CXL error handling. The first 3 patches come from Dan's
> for-6.18/cxl-probe-order branch.

I Alejandro, I can't seem to apply with this instruction:

✔ ~/git/kernel-review [review L|…9]
16:35 $ git reset --hard f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
HEAD is now at f11a5f89910a Documentation/ABI/testing/debugfs-cxl: Add 'cxl' to clear_poison path
✔ ~/git/kernel-review [review L|…9]
16:35 $ b4 shazam https://lore.kernel.org/linux-cxl/20251006100130.2623388-1-alejandro.lucero-palau@amd.com/T/#m712c7d01ffc7350d9ef638b932b9693a96fe47a9
Grabbing thread from lore.kernel.org/all/20251006100130.2623388-1-alejandro.lucero-palau@amd.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 33 messages in the thread
Analyzing 620 code-review messages
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v19 1/22] cxl/mem: Arrange for always-synchronous memdev attach
  ✓ [PATCH v19 2/22] cxl/port: Arrange for always synchronous endpoint attach
  ✓ [PATCH v19 3/22] cxl/mem: Introduce a memdev creation ->probe() operation
  ✓ [PATCH v19 4/22] cxl: Add type2 device basic support
  ✓ [PATCH v19 5/22] sfc: add cxl support
  ✓ [PATCH v19 6/22] cxl: Move pci generic code
  ✓ [PATCH v19 7/22] cxl: allow Type2 drivers to map cxl component regs
  ✓ [PATCH v19 8/22] cxl: Support dpa initialization without a mailbox
  ✓ [PATCH v19 9/22] cxl: Prepare memdev creation for type2
  ✓ [PATCH v19 10/22] sfc: create type2 cxl memdev
  ✓ [PATCH v19 11/22] cxl: Define a driver interface for HPA free space enumeration
  ✓ [PATCH v19 12/22] sfc: get root decoder
  ✓ [PATCH v19 13/22] cxl: Define a driver interface for DPA allocation
    + Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
  ✓ [PATCH v19 14/22] sfc: get endpoint decoder
  ✓ [PATCH v19 15/22] cxl: Make region type based on endpoint type
    + Reviewed-by: Davidlohr Bueso <dave@stgolabs.net> (✓ DKIM/stgolabs.net)
  ✓ [PATCH v19 16/22] cxl/region: Factor out interleave ways setup
  ✓ [PATCH v19 17/22] cxl/region: Factor out interleave granularity setup
  ✓ [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
  ✓ [PATCH v19 19/22] cxl: Avoid dax creation for accelerators
  ✓ [PATCH v19 20/22] sfc: create cxl region
  ✓ [PATCH v19 21/22] cxl: Add function for obtaining region range
  ✓ [PATCH v19 22/22] sfc: support pio mapping based on cxl
  ---
  ✓ Signed: DKIM/amd.com
  ---
  NOTE: install patatt for end-to-end signature verification
---
Total patches: 22
---
 Deps: looking for dependencies matching 23 patch-ids
 Deps: Applying prerequisite patch: [PATCH v11 01/23] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
 Deps: Applying prerequisite patch: [PATCH v11 02/23] CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
 Deps: Applying prerequisite patch: [PATCH v11 03/23] cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
 Deps: Applying prerequisite patch: [PATCH v11 04/23] cxl/pci: Remove unnecessary CXL RCH handling helper functions
 Deps: Applying prerequisite patch: [PATCH v11 05/23] cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditional block
 Deps: Applying prerequisite patch: [PATCH v11 06/23] CXL/AER: Introduce rch_aer.c into AER driver for handling CXL RCH errors
 Deps: Applying prerequisite patch: [PATCH v11 08/23] PCI/CXL: Introduce pcie_is_cxl()
 Deps: Applying prerequisite patch: [PATCH v11 09/23] PCI/AER: Report CXL or PCIe bus error type in trace logging
 Deps: Applying prerequisite patch: [PATCH v11 10/23] CXL/AER: Update PCI class code check to use FIELD_GET()
 Deps: Applying prerequisite patch: [PATCH v11 11/23] cxl/pci: Update RAS handler interfaces to also support CXL Ports
 Deps: Applying prerequisite patch: [PATCH v12 12/25] cxl/pci: Log message if RAS registers are unmapped
 Deps: Applying prerequisite patch: [PATCH v11 13/23] cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
 Deps: Applying prerequisite patch: [PATCH v12 14/25] cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
 Deps: Applying prerequisite patch: [PATCH v11 15/23] cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
 Deps: Applying prerequisite patch: [PATCH v11 17/23] CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors
 Deps: Applying prerequisite patch: [PATCH v11 18/23] PCI/AER: Dequeue forwarded CXL error
 Deps: Applying prerequisite patch: [PATCH v11 19/23] CXL/PCI: Introduce CXL Port protocol error handlers
 Deps: Applying prerequisite patch: [PATCH v11 20/23] CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
 Deps: Applying prerequisite patch: [PATCH v11 21/23] CXL/PCI: Introduce CXL uncorrectable protocol error recovery
 Deps: Applying prerequisite patch: [PATCH v11 22/23] CXL/PCI: Enable CXL protocol errors during CXL Port probe
 Deps: Applying prerequisite patch: [PATCH v11 23/23] CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
Applying: cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
Applying: CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
Applying: cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
Applying: cxl/pci: Remove unnecessary CXL RCH handling helper functions
Applying: cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditional block
Applying: CXL/AER: Introduce rch_aer.c into AER driver for handling CXL RCH errors
Applying: PCI/CXL: Introduce pcie_is_cxl()
Patch failed at 0007 PCI/CXL: Introduce pcie_is_cxl()
error: patch failed: include/uapi/linux/pci_regs.h:1274
error: include/uapi/linux/pci_regs.h: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

I also tried applying Terry's v11 first (which applied) and then this series failed as well.

DJ

> 
> v19 changes:
> 
>   Removal of cxl_acquire_endpoint and driver callback for unexpected cxl
>   module removal. Dan's patches made them unnecessary.
> 
>   patch 4: remove code already moved by Terry's patches (Ben Cheatham)
> 
>   patch 6: removed unrelated change (Ben Cheatham)
> 
>   patch 7: fix error report inconsistencies (Jonathan, Dave)
> 
>   patch 9: remove unnecessary comment (Ben Cheatham)
> 
>   patch 11: fix __free usage (Jonathan Cameron, Ben Cheatham)
> 
>   patch 13: style fixes (Jonathan Cameron, Dave Jiag)
> 
>   patch 14: move code to previous patch (Jonathan Cameron)
> 
>   patch 18: group code in one locking (Dave Jian)
> 	    use __free helper (Ben Cheatham)
> 
> 
> v18 changes:
> 
>   patch 1: minor changes and fixing docs generation (Jonathan, Dan)
>  
>   patch4: merged with v17 patch5
> 
>   patch 5: merging v17 patches 6 and 7
> 
>   patch 6: adding helpers for clarity
> 
>   patch 9:
> 	- minor changes (Dave)
> 	- simplifying flags check (Dan)
> 
>   patch 10: minor changes (Jonathan)
> 
>   patch 11:
> 	- minor changes (Dave)
> 	- fix mess (Jonathan, Dave)
> 
>   patch 18: minor changes (Jonathan, Dan)
>   
> v17 changes: (Dan Williams review)
>  - use devm for cxl_dev_state allocation
>  - using current cxl struct for checking capability registers found by
>    the driver.
>  - simplify dpa initialization without a mailbox not supporting pmem
>  - add cxl_acquire_endpoint for protection during initialization
>  - add callback/action to cxl_create_region for a driver notified about cxl
>    core kernel modules removal.
>  - add sfc function to disable CXL-based PIO buffers if such a callback
>    is invoked.
>  - Always manage a Type2 created region as private not allowing DAX.
> 
> v16 changes:
>  - rebase against rc4 (Dave Jiang)
>  - remove duplicate line (Ben Cheatham)
> 
> v15 changes:
>  - remove reference to unused header file (Jonathan Cameron)
>  - add proper kernel docs to exported functions (Alison Schofield)
>  - using an array to map the enums to strings (Alison Schofield)
>  - clarify comment when using bitmap_subset (Jonathan Cameron)
>  - specify link to type2 support in all patches (Alison Schofield)
> 
>   Patches changed (minor): 4, 11
> 
> v14 changes:
>  - static null initialization of bitmaps (Jonathan Cameron)
>  - Fixing cxl tests (Alison Schofield)
>  - Fixing robot compilation problems
> 
>   Patches changed (minor): 1, 4, 6, 13
> 
> v13 changes:
>  - using names for headers checking more consistent (Jonathan Cameron)
>  - using helper for caps bit setting (Jonathan Cameron)
>  - provide generic function for reporting missing capabilities (Jonathan Cameron)
>  - rename cxl_pci_setup_memdev_regs to cxl_pci_accel_setup_memdev_regs (Jonathan Cameron)
>  - cxl_dpa_info size to be set by the Type2 driver (Jonathan Cameron)
>  - avoiding rc variable when possible (Jonathan Cameron)
>  - fix spelling (Simon Horman)
>  - use scoped_guard (Dave Jiang)
>  - use enum instead of bool (Dave Jiang)
>  - dropping patch with hardware symbols
> 
> v12 changes:
>  - use new macro cxl_dev_state_create in pci driver (Ben Cheatham)
>  - add public/private sections in now exported cxl_dev_state struct (Ben
>    Cheatham)
>  - fix cxl/pci.h regarding file name for checking if defined
>  - Clarify capabilities found vs expected in error message. (Ben
>    Cheatham)
>  - Clarify new CXL_DECODER_F flag (Ben Cheatham)
>  - Fix changes about cxl memdev creation support moving code to the
>    proper patch. (Ben Cheatham)
>  - Avoid debug and function duplications (Ben Cheatham)
> 
> v11 changes:
>  - Dropping the use of cxl_memdev_state and going back to using
>    cxl_dev_state.
>  - Using a helper for an accel driver to allocate its own cxl-related
>    struct embedding cxl_dev_state.
>  - Exporting the required structs in include/cxl/cxl.h for an accel
>    driver being able to know the cxl_dev_state size required in the
>    previously mentioned helper for allocation.
>  - Avoid using any struct for dpa initialization by the accel driver
>    adding a specific function for creating dpa partitions by accel
>    drivers without a mailbox.
> 
> v10 changes:
>  - Using cxl_memdev_state instead of cxl_dev_state for type2 which has a
>    memory after all and facilitates the setup.
>  - Adapt core for using cxl_memdev_state allowing accel drivers to work
>    with them without further awareness of internal cxl structs.
>  - Using last DPA changes for creating DPA partitions with accel driver
>    hardcoding mds values when no mailbox.
>  - capabilities not a new field but built up when current register maps
>    is performed and returned to the caller for checking.
>  - HPA free space supporting interleaving.
>  - DPA free space droping max-min for a simple alloc size.
> 
> v9 changes:
>  - adding forward definitions (Jonathan Cameron)
>  - using set_bit instead of bitmap_set (Jonathan Cameron)
>  - fix rebase problem (Jonathan Cameron)
>  - Improve error path (Jonathan Cameron)
>  - fix build problems with cxl region dependency (robot)
>  - fix error path (Simon Horman)
> 
> v8 changes:
>  - Change error path labeling inside sfc cxl code (Edward Cree)
>  - Properly handling checks and error in sfc cxl code (Simon Horman)
>  - Fix bug when checking resource_size (Simon Horman)
>  - Avoid bisect problems reordering patches (Edward Cree)
>  - Fix buffer allocation size in sfc (Simon Horman)
> 
> v7 changes:
> 
>  - fixing kernel test robot complains
>  - fix type with Type3 mandatory capabilities (Zhi Wang)
>  - optimize code in cxl_request_resource (Kalesh Anakkur Purayil)
>  - add sanity check when dealing with resources arithmetics (Fan Ni)
>  - fix typos and blank lines (Fan Ni)
>  - keep previous log errors/warnings in sfc driver (Martin Habets)
>  - add WARN_ON_ONCE if region given is NULL
> 
> v6 changes:
> 
>  - update sfc mcdi_pcol.h with full hardware changes most not related to
>    this patchset. This is an automatic file created from hardware design
>    changes and not touched by software. It is updated from time to time
>    and it required update for the sfc driver CXL support.
>  - remove CXL capabilities definitions not used by the patchset or
>    previous kernel code. (Dave Jiang, Jonathan Cameron)
>  - Use bitmap_subset instead of reinventing the wheel ... (Ben Cheatham)
>  - Use cxl_accel_memdev for new device_type created (Ben Cheatham)
>  - Fix construct_region use of rwsem (Zhi Wang)
>  - Obtain region range instead of region params (Allison Schofield, Dave
>    Jiang)
> 
> v5 changes:
> 
>  - Fix SFC configuration based on kernel CXL configuration
>  - Add subset check for capabilities.
>  - fix region creation when HDM decoders programmed by firmware/BIOS (Ben
>    Cheatham)
>  - Add option for creating dax region based on driver decission (Ben
>    Cheatham)
>  - Using sfc probe_data struct for keeping sfc cxl data
> 
> v4 changes:
> 
>  - Use bitmap for capabilities new field (Jonathan Cameron)
>  - Use cxl_mem attributes for sysfs based on device type (Dave Jian)
>  - Add conditional cxl sfc compilation relying on kernel CXL config (kernel test robot)
>  - Add sfc changes in different patches for facilitating backport (Jonathan Cameron)
>  - Remove patch for dealing with cxl modules dependencies and using sfc kconfig plus
>    MODULE_SOFTDEP instead.
> 
> v3 changes:
> 
>  - cxl_dev_state not defined as opaque but only manipulated by accel drivers
>    through accessors.
>  - accessors names not identified as only for accel drivers.
>  - move pci code from pci driver (drivers/cxl/pci.c) to generic pci code
>    (drivers/cxl/core/pci.c).
>  - capabilities field from u8 to u32 and initialised by CXL regs discovering
>    code.
>  - add capabilities check and removing current check by CXL regs discovering
>    code.
>  - Not fail if CXL Device Registers not found. Not mandatory for Type2.
>  - add timeout in acquire_endpoint for solving a race with the endpoint port
>    creation.
>  - handle EPROBE_DEFER by sfc driver.
>  - Limiting interleave ways to 1 for accel driver HPA/DPA requests.
>  - factoring out interleave ways and granularity helpers from type2 region
>    creation patch.
>  - restricting region_creation for type2 to one endpoint decoder.
> 
> v2 changes:
> 
> I have removed the introduction about the concerns with BIOS/UEFI after the
> discussion leading to confirm the need of the functionality implemented, at
> least is some scenarios.
> 
> There are two main changes from the RFC:
> 
> 1) Following concerns about drivers using CXL core without restrictions, the CXL
> struct to work with is opaque to those drivers, therefore functions are
> implemented for modifying or reading those structs indirectly.
> 
> 2) The driver for using the added functionality is not a test driver but a real
> one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
> buffers instead of regions inside PCIe BARs.
> 
> RFC:
> 
> Current CXL kernel code is focused on supporting Type3 CXL devices, aka memory
> expanders. Type2 CXL devices, aka device accelerators, share some functionalities
> but require some special handling.
> 
> First of all, Type2 are by definition specific to drivers doing something and not just
> a memory expander, so it is expected to work with the CXL specifics. This implies the CXL
> setup needs to be done by such a driver instead of by a generic CXL PCI driver
> as for memory expanders. Most of such setup needs to use current CXL core code
> and therefore needs to be accessible to those vendor drivers. This is accomplished
> exporting opaque CXL structs and adding and exporting functions for working with
> those structs indirectly.
> 
> Some of the patches are based on a patchset sent by Dan Williams [1] which was just
> partially integrated, most related to making things ready for Type2 but none
> related to specific Type2 support. Those patches based on Dan´s work have Dan´s
> signing as co-developer, and a link to the original patch.
> 
> A final note about CXL.cache is needed. This patchset does not cover it at all,
> although the emulated Type2 device advertises it. From the kernel point of view
> supporting CXL.cache will imply to be sure the CXL path supports what the Type2
> device needs. A device accelerator will likely be connected to a Root Switch,
> but other configurations can not be discarded. Therefore the kernel will need to
> check not just HPA, DPA, interleave and granularity, but also the available
> CXL.cache support and resources in each switch in the CXL path to the Type2
> device. I expect to contribute to this support in the following months, and
> it would be good to discuss about it when possible.
> 
> [1] https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0c@intel.com/T/
> 
> Alejandro Lucero (21):
>   cxl/mem: Arrange for always-synchronous memdev attach
>   cxl/port: Arrange for always synchronous endpoint attach
>   cxl: Add type2 device basic support
>   sfc: add cxl support
>   cxl: Move pci generic code
>   cxl: allow Type2 drivers to map cxl component regs
>   cxl: Support dpa initialization without a mailbox
>   cxl: Prepare memdev creation for type2
>   sfc: create type2 cxl memdev
>   cxl: Define a driver interface for HPA free space enumeration
>   sfc: get root decoder
>   cxl: Define a driver interface for DPA allocation
>   sfc: get endpoint decoder
>   cxl: Make region type based on endpoint type
>   cxl/region: Factor out interleave ways setup
>   cxl/region: Factor out interleave granularity setup
>   cxl: Allow region creation by type2 drivers
>   cxl: Avoid dax creation for accelerators
>   sfc: create cxl region
>   cxl: Add function for obtaining region range
>   sfc: support pio mapping based on cxl
> 
> Dan Williams (1):
>   cxl/mem: Introduce a memdev creation ->probe() operation
> 
>  drivers/cxl/Kconfig                   |   2 +-
>  drivers/cxl/core/core.h               |   9 +-
>  drivers/cxl/core/hdm.c                |  85 ++++++
>  drivers/cxl/core/mbox.c               |  63 +---
>  drivers/cxl/core/memdev.c             | 209 +++++++++----
>  drivers/cxl/core/pci.c                |  63 ++++
>  drivers/cxl/core/port.c               |   1 +
>  drivers/cxl/core/region.c             | 418 +++++++++++++++++++++++---
>  drivers/cxl/core/regs.c               |   2 +-
>  drivers/cxl/cxl.h                     | 125 +-------
>  drivers/cxl/cxlmem.h                  |  90 +-----
>  drivers/cxl/cxlpci.h                  |  21 +-
>  drivers/cxl/mem.c                     | 146 +++++----
>  drivers/cxl/pci.c                     |  88 +-----
>  drivers/cxl/port.c                    |  46 ++-
>  drivers/cxl/private.h                 |  17 ++
>  drivers/net/ethernet/sfc/Kconfig      |  10 +
>  drivers/net/ethernet/sfc/Makefile     |   1 +
>  drivers/net/ethernet/sfc/ef10.c       |  50 ++-
>  drivers/net/ethernet/sfc/efx.c        |  15 +-
>  drivers/net/ethernet/sfc/efx.h        |   1 -
>  drivers/net/ethernet/sfc/efx_cxl.c    | 165 ++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
>  drivers/net/ethernet/sfc/net_driver.h |  12 +
>  drivers/net/ethernet/sfc/nic.h        |   3 +
>  include/cxl/cxl.h                     | 291 ++++++++++++++++++
>  include/cxl/pci.h                     |  21 ++
>  tools/testing/cxl/Kbuild              |   1 -
>  tools/testing/cxl/test/mem.c          |   5 +-
>  tools/testing/cxl/test/mock.c         |  17 --
>  30 files changed, 1476 insertions(+), 541 deletions(-)
>  create mode 100644 drivers/cxl/private.h
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> 
> base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
> prerequisite-patch-id: 44c914dd079e40d716f3f2d91653247eca731594
> prerequisite-patch-id: b13ca5c11c44a736563477d67b1dceadfe3ea19e
> prerequisite-patch-id: d0d82965bbea8a2b5ea2f763f19de4dfaa8479c3
> prerequisite-patch-id: dd0f24b3bdb938f2f123bc26b31cd5fe659e05eb
> prerequisite-patch-id: 2ea41ec399f2360a84e86e97a8f940a62561931a
> prerequisite-patch-id: 367b61b5a313db6324f9cf917d46df580f3bbd3b
> prerequisite-patch-id: 1805332a9f191bc3547927d96de5926356dac03c
> prerequisite-patch-id: 40657fd517f8e835a091c07e93d6abc08f85d395
> prerequisite-patch-id: 901eb0d91816499446964b2a9089db59656da08d
> prerequisite-patch-id: 79856c0199d6872fd2f76a5829dba7fa46f225d6
> prerequisite-patch-id: 6f3503e59a3d745e5ecff4aaed668e2d32da7e4b
> prerequisite-patch-id: e9dc88f1b91dce5dc3d46ff2b5bf184aba06439d
> prerequisite-patch-id: 196fe106100aad619d5be7266959bbeef29b7c8b
> prerequisite-patch-id: 7e719ed404f664ee8d9b98d56f58326f55ea2175
> prerequisite-patch-id: 560f95992e13a08279034d5f77aacc9e971332dd
> prerequisite-patch-id: 8656445ee654056695ff2894e28c8f1014df919e
> prerequisite-patch-id: 001d831149eb8f9ae17b394e4bcd06d844dd39d9
> prerequisite-patch-id: 421368aa5eac2af63ef2dc427af2ec11ad45c925
> prerequisite-patch-id: 18fd00d4743711d835ad546cfbb558d9f97dcdfc
> prerequisite-patch-id: d89bf9e6d3ea5d332ec2c8e441f1fe6d84e726d3
> prerequisite-patch-id: 3a6953d11b803abeb437558f3893a3b6a08acdbb
> prerequisite-patch-id: 0dd42a82e73765950bd069d421d555ded8bfeb25
> prerequisite-patch-id: da6e0df31ad0d5a945e0a0d29204ba75f0c97344


