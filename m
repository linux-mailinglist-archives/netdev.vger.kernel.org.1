Return-Path: <netdev+bounces-129794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D0C986227
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 17:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3715E28A26E
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC7188A33;
	Wed, 25 Sep 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLTaKfUs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9FA188A28
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276112; cv=none; b=rozpIEO9y+0HGdi+4sRFxzTuUQ6qvBwxTFI/9SSKM38Uv90xRA5Y0VBwXg87XR5BJiJClE5b11EHJnORh4W/otvaE5GT4Ae6n527WpjyttzmvKnVxMzW+Qmj+Qn/ghjYfUTo+nL9ES8M/v1u+HNQorURuCstcMPQPAJHrxefByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276112; c=relaxed/simple;
	bh=sAABImSC85bsX9/CMdYrGG7pn+XQQo/g5cd6f1ar5Hw=;
	h=MIME-Version:Content-Type:From:To:Message-ID:In-Reply-To:
	 References:Subject:Date; b=rlMpl86MwU/bQdE8demTovW4VlrGqJRNl55GEobM7Wy8i/Tp4QHljlzKmFRmzRympf6Z5Tx4DIUgDziUSCjFOuewNg1MXW2i4AT332wXQ30L83WoC5SxMofk7LhoGDxX02+LebmF+53STxuRZvBT03OgxumazCcMqnFaYFOfsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLTaKfUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE20C4CEC3;
	Wed, 25 Sep 2024 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727276112;
	bh=sAABImSC85bsX9/CMdYrGG7pn+XQQo/g5cd6f1ar5Hw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=iLTaKfUss4WwLL0jMHuRqusl2kEK99TMIfYbsh3QZeVDl5EcoB7SYZKD6PfCeVtzz
	 KqA1+QPtfzlP7DGTLcAQM4dMyy3QEbb5wPhn07thUj6c4pX/86YBl5d4QjtMv/B5wV
	 eo5xbXjitYk4H50lnf7FLKXfpTMMQkEbpG8QJEmilUxHs3hZTJjXnwDRpBHFkYy8U0
	 x3xyy2qkPSGhoSv4IDfTNlEiWyvHG/OuthPdyHBRBV1ecFlyuqGjITJPViXoVn5KDl
	 iDkHPNu/h8Hz2ApsWKwKG7ZP78Gb8edrjgbMOdDTEgP531avCyqh5kWo9RHNSWRDzk
	 IbcN2PujXzOEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B49963809A8F;
	Wed, 25 Sep 2024 14:55:15 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: netdev@vger.kernel.org, konstantin@linuxfoundation.org, 
 helpdesk@kernel.org, dkirjanov@suse.de
Message-ID: <20240925-b219323-603774918fa5@bugzilla.kernel.org>
In-Reply-To: <20240925-bizarre-earwig-from-pluto-1484aa@lemur>
References: <20240925-bizarre-earwig-from-pluto-1484aa@lemur>
Subject: Re: Bouncing maintainer: Denis Kirjanov (SUNDANCE NETWORK DRIVER)
X-Bugzilla-Product: kernel.org
X-Bugzilla-Component: Helpdesk
X-Mailer: bugspray 0.1-dev
Date: Wed, 25 Sep 2024 14:55:15 +0000 (UTC)

Hello:

This conversation is now tracked by Kernel.org Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=219323

There is no need to do anything else, just keep talking.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


