Return-Path: <netdev+bounces-28153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59DB77E68D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A5F281B3C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55010944;
	Wed, 16 Aug 2023 16:37:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFD20E7
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:37:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473BD30EF;
	Wed, 16 Aug 2023 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692203835; x=1723739835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9UeH/chb7IQAwSssem/J/NF0SyQa1tgGe+NbjTKigpA=;
  b=VF7tA2+TiHstkCrMg1n3e+8coMpF2iCcLR5vL3iVsLkFngqn3QPIY3Vb
   0srclCOenzIjqEsiyxt9pQtS1pobGhe5HsrlMUu8+//TijnQtB6+KFj6s
   MHJIWpgNUicIjOBnurmH/tqjHuOn69rAqOxwoIxKPxEj/5btEQ+57M3kK
   0HhrhzRccJcwDcqt6mvkFFBap1jYd8YLVF6NICH1xi1Z+2yi8dIwCMtRY
   sA86Es3VBPMEDJvMEEeqv0Pmebyv82XiO/7lUPtF6v5dBgoiQEKXjbGIQ
   yLFlBSCjXAW0gBAncM969XIO8U7EaT40RebmWWry134QD7weyiq89iDeo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438931550"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="438931550"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 09:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734289393"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="734289393"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2023 09:36:04 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qWJV5-0000RR-3B;
	Wed, 16 Aug 2023 16:36:03 +0000
Date: Thu, 17 Aug 2023 00:35:59 +0800
From: kernel test robot <lkp@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <202308170000.YqabIR9D-lkp@intel.com>
References: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Przemek,

kernel test robot noticed the following build errors:

[auto build test ERROR on 479b322ee6feaff612285a0e7f22c022e8cd84eb]

url:    https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/overflow-add-DEFINE_FLEX-for-on-stack-allocs/20230816-221402
base:   479b322ee6feaff612285a0e7f22c022e8cd84eb
patch link:    https://lore.kernel.org/r/20230816140623.452869-2-przemyslaw.kitszel%40intel.com
patch subject: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack allocs
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230817/202308170000.YqabIR9D-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170000.YqabIR9D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308170000.YqabIR9D-lkp@intel.com/

All errors (new ones prefixed by >>):

>> thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at_include/linux/compiler_types_h_144_2)" is not a valid Ident', /opt/cross/rustc-1.68.2-bindgen-0.56.0/cargo/registry/src/github.com-1ecc6299db9ec823/proc-macro2-1.0.24/src/fallback.rs:693:9
   stack backtrace:
      0: rust_begin_unwind
                at /rustc/9eb3afe9ebe9c7d2b84b71002d44f4a0edac95e0/library/std/src/panicking.rs:575:5
      1: core::panicking::panic_fmt
                at /rustc/9eb3afe9ebe9c7d2b84b71002d44f4a0edac95e0/library/core/src/panicking.rs:64:14
      2: proc_macro2::fallback::Ident::_new
      3: proc_macro2::Ident::new
      4: bindgen::ir::context::BindgenContext::rust_ident
      5: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
      6: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
      7: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
      8: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
      9: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
     10: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
     11: <bindgen::ir::module::Module as bindgen::codegen::CodeGenerator>::codegen
     12: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
     13: bindgen::ir::context::BindgenContext::gen
     14: bindgen::Builder::generate
     15: bindgen::main
   note: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.
   make[3]: *** [rust/Makefile:316: rust/uapi/uapi_generated.rs] Error 1
   make[3]: *** Deleting file 'rust/uapi/uapi_generated.rs'
>> thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at_include/linux/compiler_types_h_144_2)" is not a valid Ident', /opt/cross/rustc-1.68.2-bindgen-0.56.0/cargo/registry/src/github.com-1ecc6299db9ec823/proc-macro2-1.0.24/src/fallback.rs:693:9
   stack backtrace:
      0: rust_begin_unwind
                at /rustc/9eb3afe9ebe9c7d2b84b71002d44f4a0edac95e0/library/std/src/panicking.rs:575:5
      1: core::panicking::panic_fmt
                at /rustc/9eb3afe9ebe9c7d2b84b71002d44f4a0edac95e0/library/core/src/panicking.rs:64:14
      2: proc_macro2::fallback::Ident::_new
      3: proc_macro2::Ident::new
      4: bindgen::ir::context::BindgenContext::rust_ident
      5: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
      6: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
      7: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
      8: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
      9: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
     10: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
     11: <bindgen::ir::module::Module as bindgen::codegen::CodeGenerator>::codegen
     12: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
     13: bindgen::ir::context::BindgenContext::gen
     14: bindgen::Builder::generate
     15: bindgen::main
   note: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.
   make[3]: *** [rust/Makefile:310: rust/bindings/bindings_generated.rs] Error 1
   make[3]: *** Deleting file 'rust/bindings/bindings_generated.rs'
   make[3]: Target 'rust/' not remade because of errors.
   make[2]: *** [Makefile:1293: prepare] Error 2
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

