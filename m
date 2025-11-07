Return-Path: <netdev+bounces-236745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B399C3FA5F
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF2C3A5642
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E312DF14A;
	Fri,  7 Nov 2025 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PplqsP7m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA744315F
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513671; cv=none; b=p7kpIQ4QHQlWQs3ixyRpEogWmMlWl+KisaEaCkfiD/0tdGJ8MrUSrwVifMoXjlVnf+r73acdB36nq5Vldp6gEhbxmu/+7lRbuWG4gkGNUs3Tjqf9t2rnfChI7w7JYj0MWHJh4+fPNPMVYrZpi6Lb545ia0qPOO6VkHJu8iMdTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513671; c=relaxed/simple;
	bh=at0cf+2AwhWi2BTKhyLaqt7UnL8adyf22wAX09/l2ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFETi6Qg/wWh7qLz0ulXja91zfjesltZX5lkft4G1aAWB/CeAOetKrGw9RZtniZuGBUjU8UmWfg2bun9ZUgOko3/nyHuGeebUXIiyHq4+Zqmr39vaTKR/sWby2PUFy+c3J7ebn9tleK5KwE3F8RRz9PtZv/zx/5DeoGZkGVKmeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PplqsP7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487ECC116C6;
	Fri,  7 Nov 2025 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762513671;
	bh=at0cf+2AwhWi2BTKhyLaqt7UnL8adyf22wAX09/l2ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PplqsP7mbJHfLdEH984EYI/25mAnOcg0DagZ1drDk1t7a4Ago7fXmuA09OjeCRkAl
	 pTeGc4MLz2DqIVOceoCQupcbBx+eHCpjD3eLb+eP5bcYH2oslgamTHrSoxmfP9NTNj
	 Qv3/+H04xSy5oty88S820cwFWcAOxmKCFrzkYTomxN+555n4HgiB0K1vtkPr8rpCO5
	 0JqFJx41aKoGAgNQuUE7BChhIU0R5IIXqfVQ2JUxvMW6lU+cuIPkjI3Mu4PAgUyiw5
	 itAQhLcK/jKyDFJfPzS5ldfE6T6mnv556g3bN4pt+VyU1uWyIjXINHPggJ35S+dCf0
	 0LOm1SW7ja4Ag==
Date: Fri, 7 Nov 2025 11:07:48 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "joe@perches.com" <joe@perches.com>, Netdev <netdev@vger.kernel.org>
Subject: Re: check patch error.
Message-ID: <aQ3TBNhf68kZL8eV@horms.kernel.org>
References: <MN0PR18MB5847DF4315B6265D4056DC7ED3C2A@MN0PR18MB5847.namprd18.prod.outlook.com>
 <MN0PR18MB58476F66445B5736B213E9CBD3C3A@MN0PR18MB5847.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR18MB58476F66445B5736B213E9CBD3C3A@MN0PR18MB5847.namprd18.prod.outlook.com>

On Fri, Nov 07, 2025 at 02:34:49AM +0000, Ratheesh Kannoth wrote:
> I think, this is false positive.  Could you comment ?

I was not able to reproduce this.
But, FWIIW, it does look like a false positive to me.

Also, please don't top-post on Kernel mailing lists.

