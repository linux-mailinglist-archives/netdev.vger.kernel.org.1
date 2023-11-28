Return-Path: <netdev+bounces-51815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3DA7FC534
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D57B215E5
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408A41C76;
	Tue, 28 Nov 2023 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncbc7Kqm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37F83;
	Tue, 28 Nov 2023 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701202949; x=1732738949;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5a9+cqvWMbcyuzJdN5sdcVcbsN9zqY5j2FPt3BXfm2g=;
  b=ncbc7Kqm3VCMyFtoy5HrLbz/Uz/jCx2q606hGeenVljx0PulAxq4iivG
   EmHnS7iZbA6q9bD2R19B0zV0rZ+DtAKZUQ3yPmlrL7MH08nkHQ454PQVh
   6IYt6x+sQa3eqjEGy/nKD2kd4Uz8BoJGjKxk+SwtSHcUi5vYs5uUzrulw
   +L2IURIQvDGNpAI2OpVcAaGMfb3SDrYrFNkoFPG64rPDrkWfCEEm6G4Es
   W7dwAAhxIq+BmhdAnFJBoLlvnJyowIuv5jhT7F0Q5lQLsR9/ZnKGyr3qz
   ArQkEUvjCzjgqPr4ONRc9sQyPY4w7tztTb2vcOAWnLW9WnluwwwWezwZq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424166467"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="424166467"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:22:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="17036986"
Received: from ticela-or-268.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.190.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:22:28 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net/sched: cbs: Use units.h instead of
 the copy of a definition
In-Reply-To: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
References: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
Date: Tue, 28 Nov 2023 12:22:27 -0800
Message-ID: <87h6l5sk58.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> BYTES_PER_KBIT is defined in units.h, use that definition.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


-- 
Vinicius

