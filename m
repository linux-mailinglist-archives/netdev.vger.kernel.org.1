Return-Path: <netdev+bounces-151723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3409F0BBA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C47B163E1C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903021DEFD9;
	Fri, 13 Dec 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIZfGVN+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB634A21
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090914; cv=none; b=PWfpp7/xRb5b0/1FEu3Jcy6IG9Gf6Pp+9EuuqmacPUZ068bNfA2SHZ+4qA/+xyymR/BUeEiOncl+PkwkD7+mJuj0EPEOffk6YIFttvVikwdmv+wOGxNPHc9VUd0OhZkhVQLW8cMFsVk3hNpV814gQqC44MxEzmPqonEdR2A19wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090914; c=relaxed/simple;
	bh=J9IlNwTsvzqNL+tA2jbFJBV6BSl+/K2eaCgauGcWQMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q96KL82Zj5Si3/I4iv1guuDAnZktvga+ZwplX+d6hLehiRP8cnm21Hv8YstotczRXo25wIT9vxQTDpLeLmwftPgPwcgaNPVSFQAPN84FImz66BGsBhBQg+t0BjtI2geF+Q/yXMp/Ll5H+adaATPecnhq2i9NLKKc/Wd7LCVgy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIZfGVN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FCEC4CED0;
	Fri, 13 Dec 2024 11:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734090914;
	bh=J9IlNwTsvzqNL+tA2jbFJBV6BSl+/K2eaCgauGcWQMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIZfGVN+mDUQgpbt56LPJhmTomBYDfsBnra6qeYfnWwyOf+Lhnzu0oFC9Sg6zW4L7
	 aCgaTJ1JC4w39rG17hnOCbdEZE/wDkp3l8fPnuei9MrUEf8UkLEQy1RRg9nEX8uQvg
	 XqkB+Vl9RbgS56XydiSYiZJwVwxolqfxke+Zb6Ud80gDmzP3+olpWTsRyr8emWTqoO
	 +wVQqjsSu7U1taIhgzCcQdQB1tLc78xXVyEBk43Cf6l27hdFcpOpDMIZsPxm1GzDRJ
	 tH0CbY/Tfh+M+nVIOiRz1/5ov7dkFKo3Asmh1iu3oAu5RmuUpdIhjg2SSoPa4EH+BP
	 slPZEo8r1iysw==
Date: Fri, 13 Dec 2024 11:55:10 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-next 3/3] ice: remove special delay after processing
 a GNSS read batch
Message-ID: <20241213115510.GR2110@kernel.org>
References: <20241212153417.165919-1-mschmidt@redhat.com>
 <20241212153417.165919-4-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212153417.165919-4-mschmidt@redhat.com>

On Thu, Dec 12, 2024 at 04:34:17PM +0100, Michal Schmidt wrote:
> I do not see a reason to have a special longer delay (100 ms) after
> passing read GNSS data to userspace.
> 
> Just use the regular GNSS polling interval (20 ms).
> 
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


