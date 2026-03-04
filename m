Return-Path: <netdev+bounces-263706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCU+NKYAqGnynAAAu9opvQ
	(envelope-from <netdev+bounces-263706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:51:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 677271FDE69
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B97E6302E13B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412473822AC;
	Wed,  4 Mar 2026 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csEKBYBu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90F349B16;
	Wed,  4 Mar 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617890; cv=none; b=kP1xRk/XSQX7EY2tOsp5Yq+h1mSXVYd3BaqnPS06KypHpeholGyBS4T7q2crQNsAgAJ3qtpdNPfWgmGKDQ1OfxrWff59YjjFzV5tzPMV5nSKihl3xYGBQtKJB0MhCneDMj5rT+hYmSkl2NxHjDGOCUn7rgbk3Erx3PDyMIaIpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617890; c=relaxed/simple;
	bh=hOx8/u7ut1L3MguJoU5B49CkW48rFlxVpSD60jdidy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A7T6zLxzH5VuJgOLNz8l9w9hunTjc8hsxEfo2HvOUh2oDDdtqH0GtxQNSR+/+TbxhNhQp8qcJJPSP6Iai5Yu3+Kq6LXi9zAKF7ZVeRoJRzv7r8F1AlrOKoqZL/D4WOeQqUg0Mz/nn9oxpox2kB7XNshme9IIagMGdL9WHgqVocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csEKBYBu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772617887; x=1804153887;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hOx8/u7ut1L3MguJoU5B49CkW48rFlxVpSD60jdidy0=;
  b=csEKBYBuAX//Y2+Brl6PPI6zqp5CBjVFW7BFFZD8ozMomJaKA1v+9Ptl
   WerKnqd/YnuevJ1WL5jOMawfpLcK9tO9zDqFb7JHNgpwZYi9pwC62da79
   hrLymL/xCj38pN7AY5ahvsHMfEG4SDWOBlT6wE0I1eZK1H3bjgnqlQ5Md
   wxcrkEqFAfv7ZKYiwjYasAKr8ULQm12XqPXmyICvk43ulKODGvFndg3D3
   XqoyMCRIk2yrDsNTSY1ro4cNlJTt7x0wG5soBA7v5nDEdrco8A/6tUpID
   boK3tgTWB1fmEtqjrk8TwTsszS/KfGKaHXj7JI8v842kYe2GiVtCrpa6g
   w==;
X-CSE-ConnectionGUID: BRSQMSytQgGfiP79giFJNw==
X-CSE-MsgGUID: ojRkMuIgSWuQ8FdSBb0TPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73374994"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="73374994"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 01:51:26 -0800
X-CSE-ConnectionGUID: 1Ea7458+RDWErlLELTBiWg==
X-CSE-MsgGUID: 4l180kpJQLGqACFXzt6ovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="217531444"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.84])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 01:51:22 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
In-Reply-To: <20260303155310.5235b367@localhost>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
 <20260303155310.5235b367@localhost>
Date: Wed, 04 Mar 2026 11:51:18 +0200
Message-ID: <b345179eb9c440c597f6618697b7272a8e383eff@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 677271FDE69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263706-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> On Mon, 23 Feb 2026 15:47:00 +0200
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> There's always the question, if you're putting a lot of effort into
>> making kernel-doc closer to an actual C parser, why not put all that
>> effort into using and adapting to, you know, an actual C parser?
>
> Playing with this idea, it is not that hard to write an actual C
> parser - or at least a tokenizer.

Just for the record, I suggested using an existing parser, not going all
NIH and writing your own.

BR,
Jani.

-- 
Jani Nikula, Intel

