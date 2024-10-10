Return-Path: <netdev+bounces-134098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB80A997FB5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB4F1C23569
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03ED1FA26B;
	Thu, 10 Oct 2024 07:44:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400161C3F13
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546253; cv=none; b=SCUauK/uuX67s09zo9OOXMBZL/l0/z2DHBvcHhewr22/RE5/Y4KkJzr/sFtDjySbFS/NiVTW0grBHrOKIEH3lqC/nz/PHq6iNQ2YSZm0E9CYlzEb015eYkmbVoyDyCDiMP/gYzl2Q8hVVHHADW2qbx/YyMBuoh6QC4DY516Pe78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546253; c=relaxed/simple;
	bh=RAPc7tFMJ/5yui4fecf+3c9aVUDQk3j2atmVR4eNFGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbsnzlmp4syf8m5i1TdgTJzN43G1t2J20zENuljpgPMdpmIvm88TBnY8Yp9IrNPZ3+H/kOITKietI5FbGuHUpKKnDiDtjG9FYAMQQCP3sfXriB5L5htFc5Hsb/7RNIC+Z+hf/S0WLy+rGVFAFazEFTYnQXAAO8p2fb+KNkpXOGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5ae839.dynamic.kabel-deutschland.de [95.90.232.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DB89E61E5FE05;
	Thu, 10 Oct 2024 09:43:48 +0200 (CEST)
Message-ID: <635d2ba6-985b-4fd6-a7b3-c5aeb1804aa6@molgen.mpg.de>
Date: Thu, 10 Oct 2024 09:43:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 0/4] Fix E825 initialization
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
References: <20241009140223.1918687-1-karol.kolacinski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241009140223.1918687-1-karol.kolacinski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Karol,


Am 09.10.24 um 15:59 schrieb Karol Kolacinski:
> E825 products have incorrect initialization procedure, which may lead to
> initialization failures and register values.
> 
> Fix E825 products initialization by adding correct sync delay, checking the
> PHY
> revision only for current PHY and adding proper destination device when
> reading
> port/quad.
> 
> In addition, E825 uses PF ID for indexing per PF registers and as a primary
> PHY
> lane number, which is incorrect.

Just a note, that the lines were additionally wrapped by some part in 
the processing queue.


Kind regards,

Paul

