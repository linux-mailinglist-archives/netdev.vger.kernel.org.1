Return-Path: <netdev+bounces-188697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E13AAE402
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7F19A0490
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EBA2147F6;
	Wed,  7 May 2025 15:11:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0228A40A;
	Wed,  7 May 2025 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630719; cv=none; b=bGRz2ZjrgtcC4zoh7XueOeMGz0h+RaYCal/3k+mxkeZ4mDCQuXAyra0aitfcBXdUQpzGyRsdwiCB34LFcWup326Q6QalosHpTKcUte8DqCABQciD0j9q4bm3fqZCPTraJ03sI0X0z+7yn6tB0T2wGHzn8yS4tyERPND0VJc0wr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630719; c=relaxed/simple;
	bh=bj2T+Ypfg+FWZuignqkhY31+iLmm/vIazhptgRHbs1c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6okJv0VbaMzNzPpbWbrjB2/F/vizn9NAO1xZtUSVC8zKAFYkVzaM3L0UvbIb7dRldPk2IBJaSF1Kvzl8TSSDT7kzGTAvg5oybPenzA/99DGyZ5ew4rtTP7OiZvH0h7zNT98YYNsF4vuReAjwSSANwI192ts2Fq1BBKYrQ0TrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZszFK3FXdz6L5RY;
	Wed,  7 May 2025 23:09:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D2AFB1402F7;
	Wed,  7 May 2025 23:11:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 May
 2025 17:11:52 +0200
Date: Wed, 7 May 2025 16:11:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v14 00/22] Type2 device basic support
Message-ID: <20250507161150.00000223@huawei.com>
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Apr 2025 22:29:03 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>

Hi Alejandro / All,

I'll ping on CXL discord for this a few minutes as well, but to me this ser=
ies looks
good subject to a few trivial things that can be easily cleaned up in a v15
(or maybe by Dave when picking it up).

However, some of the SFC patches need tags from SFC driver folk.  I'm also
not sure what convention is for necessary tags if we route the SFC net driv=
er
changes through the CXL tree.  A quick query of a conveniently situated
maintainer of a different ethernet driver suggested we'd need at least
an Ack from one of the networking driver maintainers along with sfc maintai=
ners
(so same as most other subsystems!)

Alternative might be to do this across two cycles or with an immutable bran=
ch.
That would require reordering or calling out specific patches to take
via CXL.    Alejandro, we could figure it out but better if you send=20
a list of what would merge that way via which tree,

Jonathan

>=20
> v14 changes:
>  - static null initialization of bitmaps (Jonathan Cameron)
>  - Fixing cxl tests (Alison Schofield)
>  - Fixing robot compilation problems
>=20
>   Patches changed (minor): 1, 4, 6, 13
>=20
> v13 changes:
>  - using names for headers checking more consistent (Jonathan Cameron)
>  - using helper for caps bit setting (Jonathan Cameron)
>  - provide generic function for reporting missing capabilities (Jonathan =
Cameron)
>  - rename cxl_pci_setup_memdev_regs to cxl_pci_accel_setup_memdev_regs (J=
onathan Cameron)
>  - cxl_dpa_info size to be set by the Type2 driver (Jonathan Cameron)
>  - avoiding rc variable when possible (Jonathan Cameron)
>  - fix spelling (Simon Horman)
>  - use scoped_guard (Dave Jiang)
>  - use enum instead of bool (Dave Jiang)
>  - dropping patch with hardware symbols
> =20
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
>  - Fix robot compilation error reported by Simon Horman as well.
>  - Add doc about new param in clx_create_region (Simon Horman).
>=20
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
>=20
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
>=20
> v9 changes:
>  - adding forward definitions (Jonathan Cameron)
>  - using set_bit instead of bitmap_set (Jonathan Cameron)
>  - fix rebase problem (Jonathan Cameron)
>  - Improve error path (Jonathan Cameron)
>  - fix build problems with cxl region dependency (robot)
>  - fix error path (Simon Horman)
>=20
> v8 changes:
>  - Change error path labeling inside sfc cxl code (Edward Cree)
>  - Properly handling checks and error in sfc cxl code (Simon Horman)
>  - Fix bug when checking resource_size (Simon Horman)
>  - Avoid bisect problems reordering patches (Edward Cree)
>  - Fix buffer allocation size in sfc (Simon Horman)
>=20
> v7 changes:
>=20
>  - fixing kernel test robot complains
>  - fix type with Type3 mandatory capabilities (Zhi Wang)
>  - optimize code in cxl_request_resource (Kalesh Anakkur Purayil)
>  - add sanity check when dealing with resources arithmetics (Fan Ni)
>  - fix typos and blank lines (Fan Ni)
>  - keep previous log errors/warnings in sfc driver (Martin Habets)
>  - add WARN_ON_ONCE if region given is NULL
>=20
> v6 changes:
>=20
>  - update sfc mcdi_pcol.h with full hardware changes most not related to=
=20
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
>=20
> v5 changes:
>=20
>  - Fix SFC configuration based on kernel CXL configuration
>  - Add subset check for capabilities.
>  - fix region creation when HDM decoders programmed by firmware/BIOS (Ben
>    Cheatham)
>  - Add option for creating dax region based on driver decission (Ben
>    Cheatham)
>  - Using sfc probe_data struct for keeping sfc cxl data
>=20
> v4 changes:
>  =20
>  - Use bitmap for capabilities new field (Jonathan Cameron)
>=20
>  - Use cxl_mem attributes for sysfs based on device type (Dave Jian)
>=20
>  - Add conditional cxl sfc compilation relying on kernel CXL config (kern=
el test robot)
>=20
>  - Add sfc changes in different patches for facilitating backport (Jonath=
an Cameron)
>=20
>  - Remove patch for dealing with cxl modules dependencies and using sfc k=
config plus
>    MODULE_SOFTDEP instead.
>=20
> v3 changes:
>=20
>  - cxl_dev_state not defined as opaque but only manipulated by accel driv=
ers
>    through accessors.
>=20
>  - accessors names not identified as only for accel drivers.
>=20
>  - move pci code from pci driver (drivers/cxl/pci.c) to generic pci code
>    (drivers/cxl/core/pci.c).
>=20
>  - capabilities field from u8 to u32 and initialised by CXL regs discover=
ing
>    code.
>=20
>  - add capabilities check and removing current check by CXL regs discover=
ing
>    code.
>=20
>  - Not fail if CXL Device Registers not found. Not mandatory for Type2.
>=20
>  - add timeout in acquire_endpoint for solving a race with the endpoint p=
ort
>    creation.
>=20
>  - handle EPROBE_DEFER by sfc driver.
>=20
>  - Limiting interleave ways to 1 for accel driver HPA/DPA requests.
>=20
>  - factoring out interleave ways and granularity helpers from type2 region
>    creation patch.
>=20
>  - restricting region_creation for type2 to one endpoint decoder.
>=20
>  - add accessor for release_resource.
>=20
>  - handle errors and errors messages properly.
>=20
>=20
> v2 changes:
>=20
> I have removed the introduction about the concerns with BIOS/UEFI after t=
he
> discussion leading to confirm the need of the functionality implemented, =
at
> least is some scenarios.
>=20
> There are two main changes from the RFC:
>=20
> 1) Following concerns about drivers using CXL core without restrictions, =
the CXL
> struct to work with is opaque to those drivers, therefore functions are
> implemented for modifying or reading those structs indirectly.
>=20
> 2) The driver for using the added functionality is not a test driver but =
a real
> one: the SFC ethernet network driver. It uses the CXL region mapped for P=
IO
> buffers instead of regions inside PCIe BARs.
>=20
>=20
>=20
> RFC:
>=20
> Current CXL kernel code is focused on supporting Type3 CXL devices, aka m=
emory
> expanders. Type2 CXL devices, aka device accelerators, share some functio=
nalities
> but require some special handling.
>=20
> First of all, Type2 are by definition specific to drivers doing something=
 and not just
> a memory expander, so it is expected to work with the CXL specifics. This=
 implies the CXL
> setup needs to be done by such a driver instead of by a generic CXL PCI d=
river
> as for memory expanders. Most of such setup needs to use current CXL core=
 code
> and therefore needs to be accessible to those vendor drivers. This is acc=
omplished
> exporting opaque CXL structs and adding and exporting functions for worki=
ng with
> those structs indirectly.
>=20
> Some of the patches are based on a patchset sent by Dan Williams [1] whic=
h was just
> partially integrated, most related to making things ready for Type2 but n=
one
> related to specific Type2 support. Those patches based on Dan=B4s work ha=
ve Dan=B4s
> signing as co-developer, and a link to the original patch.
>=20
> A final note about CXL.cache is needed. This patchset does not cover it a=
t all,
> although the emulated Type2 device advertises it. From the kernel point o=
f view
> supporting CXL.cache will imply to be sure the CXL path supports what the=
 Type2
> device needs. A device accelerator will likely be connected to a Root Swi=
tch,
> but other configurations can not be discarded. Therefore the kernel will =
need to
> check not just HPA, DPA, interleave and granularity, but also the availab=
le
> CXL.cache support and resources in each switch in the CXL path to the Typ=
e2
> device. I expect to contribute to this support in the following months, a=
nd
> it would be good to discuss about it when possible.
>=20
> [1] https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0=
c@intel.com/T/
>=20
> Alejandro Lucero (22):
>   cxl: add type2 device basic support
>   sfc: add cxl support
>   cxl: move pci generic code
>   cxl: move register/capability check to driver
>   cxl: add function for type2 cxl regs setup
>   sfc: make regs setup with checking and set media ready
>   cxl: support dpa initialization without a mailbox
>   sfc: initialize dpa
>   cxl: prepare memdev creation for type2
>   sfc: create type2 cxl memdev
>   cxl: define a driver interface for HPA free space enumeration
>   sfc: obtain root decoder with enough HPA free space
>   cxl: define a driver interface for DPA allocation
>   sfc: get endpoint decoder
>   cxl: make region type based on endpoint type
>   cxl/region: factor out interleave ways setup
>   cxl/region: factor out interleave granularity setup
>   cxl: allow region creation by type2 drivers
>   cxl: add region flag for precluding a device memory to be used for dax
>   sfc: create cxl region
>   cxl: add function for obtaining region range
>   sfc: support pio mapping based on cxl
>=20
>  drivers/cxl/core/core.h               |   2 +
>  drivers/cxl/core/hdm.c                |  77 +++++
>  drivers/cxl/core/mbox.c               |  30 +-
>  drivers/cxl/core/memdev.c             |  47 ++-
>  drivers/cxl/core/pci.c                | 146 +++++++++
>  drivers/cxl/core/port.c               |   8 +-
>  drivers/cxl/core/region.c             | 415 +++++++++++++++++++++++---
>  drivers/cxl/core/regs.c               |  37 +--
>  drivers/cxl/cxl.h                     | 111 +------
>  drivers/cxl/cxlmem.h                  | 103 +------
>  drivers/cxl/cxlpci.h                  |  23 +-
>  drivers/cxl/mem.c                     |  25 +-
>  drivers/cxl/pci.c                     | 111 ++-----
>  drivers/cxl/port.c                    |   5 +-
>  drivers/net/ethernet/sfc/Kconfig      |  10 +
>  drivers/net/ethernet/sfc/Makefile     |   1 +
>  drivers/net/ethernet/sfc/ef10.c       |  50 +++-
>  drivers/net/ethernet/sfc/efx.c        |  15 +-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 159 ++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
>  drivers/net/ethernet/sfc/net_driver.h |  12 +
>  drivers/net/ethernet/sfc/nic.h        |   3 +
>  include/cxl/cxl.h                     | 276 +++++++++++++++++
>  include/cxl/pci.h                     |  36 +++
>  tools/testing/cxl/Kbuild              |   1 -
>  tools/testing/cxl/test/mem.c          |   3 +-
>  tools/testing/cxl/test/mock.c         |  17 --
>  27 files changed, 1346 insertions(+), 417 deletions(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
>=20
>=20
> base-commit: 73c117c17b562213242f432db2ddf1bcc22f39dd


