Return-Path: <netdev+bounces-44842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BBF7DA16C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CFDB213E3
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29C3DFE0;
	Fri, 27 Oct 2023 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaWLkhZ6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5813AC22
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 19:42:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F42BE5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698435721; x=1729971721;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cgHfy1RNnKl6IrYFQfoLyEGL3R+Vvi7oXV+nJLMJKfk=;
  b=MaWLkhZ6qPuZX12xJKDTUXBa/Gp1xVLFzUMc/rwHlBIuNWMo3w1KrC26
   Lo7y55YKDPvqhLdauUduNS5pifljeuiTXLnoyo9Iw4DCzMJrrKo91chg8
   gv08kBiUMr1gCqEP2ptix8BrbxvPgZU9omsnQs++FHKiO92NwmFVCw7Ek
   cMq3Qfre2iFM/a5/CFdP9RvxIuPpJfghfeypMQE0+MLbmrw5fFbyxIqjh
   pATSzn19N25VbOf+4xBwFAnifqgjXrPSBoZpT9Sh/zl1hUefXxsTeYXEH
   V5r75mn1v2bFNawaaYL9Xz1WM87e5Jn9YoEcj65+nEG3Sd6i0yOmTcSJW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="386727857"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="386727857"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 12:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="7732358"
Received: from sayaliss-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.238.212])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 12:41:48 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, stephen@networkplumber.org
Cc: netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next 0/3] net: sched: Fill in missing
 MODULE_DESCRIPTIONs for net/sched
In-Reply-To: <20231027155045.46291-1-victor@mojatatu.com>
References: <20231027155045.46291-1-victor@mojatatu.com>
Date: Fri, 27 Oct 2023 12:42:00 -0700
Message-ID: <87fs1vrgxj.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Victor Nogueira <victor@mojatatu.com> writes:

> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
>
> Fill in the missing MODULE_DESCRIPTIONs for net/sched
>
> Victor Nogueira (3):
>   net: sched: Fill in MODULE_DESCRIPTION for act_gate

The most optional of comments: missing "missing", just for consistency
with the rest of the series. Totally fine to ignore.

Reviewed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

