Return-Path: <netdev+bounces-109012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198BF926802
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D669728916F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33894186280;
	Wed,  3 Jul 2024 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwLjVKpz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E917B4E8
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030885; cv=none; b=COCJxcn5F/k7c/VUbqPkxCZYUWBouT5PcbDarAQeAzHWSzTRGf9WqAg11ZMgqHIBF8gjCTIPvVbWA6MheR3U1ygD7D/emFwtr5l7zYrC5YGsEVJ57v3woqV5RMJWviE5XqQ7LpSSyrdwPNth926iLaH+TZPNTDxnQocMfJHMSyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030885; c=relaxed/simple;
	bh=SsDyoKEIMJ6w9gucOeLK7ZZDgj2jQuEMvrJMpUJ1L7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucVZH9nMLIlqPt3jw5+bkzNJZI6bKrya/Psee6G/o81+kf9hNMKg/zd8/ey+wnNHvWFKYcFFlgaDE3Pt5PNRqeIU/TGCRNvu42wX25fMVb4i1e6DqUYLqZSSuMiJ4FELgjXnb1mGgkUWYEgfGgRGitDa8Az3nfdo1aV2tSPGMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwLjVKpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31907C32781;
	Wed,  3 Jul 2024 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720030884;
	bh=SsDyoKEIMJ6w9gucOeLK7ZZDgj2jQuEMvrJMpUJ1L7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwLjVKpzdBtgrBpm9iQIVxPEwg5lSWkihGC1xqcCaS76V8WRngSnyEMsLIiklCC7i
	 u9lcAQz0LTzMAFNP8Sd6s0c2/9QzfvhOYVvS97TsnAUxQzpwh1bR0lIl/LGclCj9W5
	 bKXt1amCeHJzqM5HRoHUAHxvw70c8BebsOa+ngOFjN04OkvUnCS5KfTq4ec8eiJtJJ
	 q5HUgQsVQc2cxWwjH1AP2sFDjS7gl10qyDEnQZBhx5AC6NnAhhPl4uJnt//zRsrgAu
	 U2kARFZPqAvBymIc1NQz7msiOYXlNrU7nBKkxzAS6xao/yhU4iOTIMHa2RO3QlbIdN
	 BSQzJONat++7A==
Date: Wed, 3 Jul 2024 19:21:21 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH v2 iwl-next 7/7] ice: Enable 1PPS out from CGU for E825C
 products
Message-ID: <20240703182121.GP598357@kernel.org>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-16-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702134448.132374-16-karol.kolacinski@intel.com>

On Tue, Jul 02, 2024 at 03:41:36PM +0200, Karol Kolacinski wrote:
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> 
> Implement configuring 1PPS signal output from CGU. Use maximal amplitude
> because Linux PTP pin API does not have any way for user to set signal
> level.
> 
> This change is necessary for E825C products to properly output any
> signal from 1PPS pin.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: Added return value description, renamed the function and
>           enable parameter. Reworded commit message.

Reviewed-by: Simon Horman <horms@kernel.org>


