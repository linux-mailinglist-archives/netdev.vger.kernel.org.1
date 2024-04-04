Return-Path: <netdev+bounces-84673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D93897D85
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 03:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A981C218C6
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96901758F;
	Thu,  4 Apr 2024 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2jAn6zg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA72F37
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712195581; cv=none; b=bREmG2v+gb98pLvJYe+h5o+LPVgmt4mTVPnQjnoDZht0FF/83S59qqq9GcWLm6YVO+7yBogS20JAv/gX/ZuMZAz7ILE6xoL1vJkTmjyq2BF9ymT1rculHz/WVjn1Ja/O8+NPuvz35kQnsFBs5epgSlZTg1X+qYbzAQTnhSv6l5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712195581; c=relaxed/simple;
	bh=rRQkB/2uqKZF0P31rAziA8rhsj1SCGdb8A62U/nbDzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UEaahmNRwoak58970P3kzodlSdAhAdXS+gLPfI2L0sJP9d6ZVpytb3onwaAaWPvFAMhvgtSDSdGMadOKsFTjabizyd4jiGucXcCAauwUjCWXCBNQG2Wq5RJ6VigfSrrBvNOHuMueAvj31svhLZXqatZGFyHbU43qSiYx8Y4mgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2jAn6zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8438C433F1;
	Thu,  4 Apr 2024 01:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712195581;
	bh=rRQkB/2uqKZF0P31rAziA8rhsj1SCGdb8A62U/nbDzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m2jAn6zgw6GmlQpyrropOEQUykaM6zJN2fltddWJLz6LSrbPdOvLnpYZH9nbV177W
	 WmIWpUAGQ47Ri7t5O8is1jb9Z1FSWqpXjhWkKwAtdEmGs1ULYXawN/8oGQs8KA+qJB
	 FaBhBvWX19s4chYQHsuBT/J3Q8/KMPq+RaVxZdOhqJtiuZUC+i2SRUFHb2Ku2LeGq+
	 jTNYrHg286irHGI9wgDgs2odyE3BrkwhcDXSI8KRysfaqznDAR2SLuEz07hyQ8twdj
	 1KS9uLjLffyCzCfE7F8McJ2c8JHmLjexVHpUVRhglLTDZw6yqUYXSXZu4Y4JxMYdE8
	 JARFYDQymsIqw==
Date: Wed, 3 Apr 2024 18:53:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com
Subject: Re: [PATCH net-next v2 7/7] net: txgbe: add sriov function support
Message-ID: <20240403185300.702a8271@kernel.org>
In-Reply-To: <BDE9D80ABE699DA7+20240403092714.3027-8-mengyuanlou@net-swift.com>
References: <20240403092714.3027-1-mengyuanlou@net-swift.com>
	<BDE9D80ABE699DA7+20240403092714.3027-8-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 17:10:04 +0800 Mengyuan Lou wrote:
> +	.ndo_set_vf_spoofchk    = wx_ndo_set_vf_spoofchk,
> +	.ndo_set_vf_link_state	= wx_ndo_set_vf_link_state,
> +	.ndo_get_vf_config      = wx_ndo_get_vf_config,
> +	.ndo_set_vf_vlan        = wx_ndo_set_vf_vlan,
> +	.ndo_set_vf_mac         = wx_ndo_set_vf_mac,

We don't accept any new implementations of the old SR-IOV API.
Please offload standard networking constructs like flow rules,
bridge etc.
-- 
pw-bot: reject

