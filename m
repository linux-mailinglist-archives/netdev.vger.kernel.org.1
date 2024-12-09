Return-Path: <netdev+bounces-150135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A319E911C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6CC1619E3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2031E216E28;
	Mon,  9 Dec 2024 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2qXj8Ww"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36A21639E
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741996; cv=none; b=gQDWlf1hnMDcfQN05PLw9DjZsW1afVsMAJjP4NKpdGtIPKz4Wy9f3oNDBP3Nts0Ed1/AO1bMGWDtYA32sAp/VhoznqxPIVVPLfF2ebGMkXuDHDmsHcUdVGTo8XEhsg+I+jcmTEcvYfynWvHhDDUxd/uN0uY7575GA3A/2v3iOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741996; c=relaxed/simple;
	bh=vVSn0qA0S1DI2U8e2PuF/3DS3hHPajmewcph9qnd/KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK9ZRkS1KeT0sKp+Qn7yGLbour/tEIB6hy8m6cA4LdkicvO8e3+54yG/4HbuOLll6q8C75GPMQPxcrXTwcERPB+/ld4kSIApm5o9r7gjPEA45dvrIvlz3VUHjXlf63FlIgEU0JQGqyrETtz2sca+3RJptP65BNDj5JAMAF1Vpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2qXj8Ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB8EC4CEDE;
	Mon,  9 Dec 2024 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733741995;
	bh=vVSn0qA0S1DI2U8e2PuF/3DS3hHPajmewcph9qnd/KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2qXj8WwuRXaF71dpnqWMwhshDZadQuPqAMKkUoxd22VzdHn6v+ci+eDOhYC8S3bw
	 iB7+6NEG/tcYBNezSGPpJLFM+tUZ4mcgSRiwAcTcwddos7qS5fusaDvCyveWlGegEP
	 z40T/T5i8eeqwO1Dn7LSqAV2uaei1nyZ752xYVFPfm+TPltFHVJp8zVmAqxUcHJbjR
	 aU1TseIAH2VzJNBou5tVbvMsONsAJUWFViF7cUKho3pKJJyFKqQ17Df8wobSWiePl/
	 j1tgbyAYSpHwIaqo89sMuow9caBh2PfGeiI8zijSB6uHZ9ZCvsX6xJzxk0PWwFh5jh
	 ggO0rJSsSR4ng==
Date: Mon, 9 Dec 2024 10:59:51 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v12 5/8] ixgbe: Add support for EEPROM dump in
 E610 device
Message-ID: <20241209105951.GZ2581@kernel.org>
References: <20241205084450.4651-1-piotr.kwapulinski@intel.com>
 <20241205084450.4651-6-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205084450.4651-6-piotr.kwapulinski@intel.com>

On Thu, Dec 05, 2024 at 09:44:47AM +0100, Piotr Kwapulinski wrote:
> Add low level support for EEPROM dump for the specified network device.
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


