Return-Path: <netdev+bounces-101199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B506B8FDB9E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B50C1F23DD9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340E88F58;
	Thu,  6 Jun 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQA4bRQn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30B53A7;
	Thu,  6 Jun 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635038; cv=none; b=eA6jSgLNLEqvYBhE5URrw29W3eFLRwS+epITtcqa69oh2wRkYVoA8Czh3DrHJTmGDjA+Zwcrdkze92LCbBeUneXaHRQbussd6mAembGIwxt+VqSxfWQ3WV03xHv4Cd6cutmKj0DBu3Bwon5ApGafZK0Zxh7c5JSTzXEb9J1+BxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635038; c=relaxed/simple;
	bh=UWnvyfa3iJgXi7I827PAz0W2MYHsx4oBEHwa4G5Zn2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKdzrISTSU3MjLblyx4uCEdWwDMOiZqFlkU5G4gbqV17WOggKRWVK4JUm+k4GurOjf2jW9AYG/53ANMDJE4OUSxbT5DOPId0ESkcaEY4Gmx/0scPLL9OckXvLOGExYCS4rDEecF8REDdrgsH3JAofInn+e26epDj+RlTM12C41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQA4bRQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873DEC3277B;
	Thu,  6 Jun 2024 00:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717635037;
	bh=UWnvyfa3iJgXi7I827PAz0W2MYHsx4oBEHwa4G5Zn2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TQA4bRQnHe7EL2iYa519cn0Pd0KXVVXjvL3ysDhz7+9HiW6TVmpT78azm5VqEKQJf
	 l+8htn1BwdhQ5CJCSXarkrG9f9baUGWN/QbudcwxTYT16U/p50ktj/GWqTG/ZAqwvh
	 Ii3RNKgW/FrkY+BrKQeQQW0KLpA5n/RyNnbU/a6RW6AxAldDtNSc3yXU2LnAYs9+7G
	 tOPkeDGugv/KKYWJ269dGN0yo9e6zIALYC1IZNG7hdnh842+O9SUNiHoWC9Z1FKSFs
	 OuY/gEMWorRWcgSZk+Pw98dYI98b5RYU2gO20imWl2ile0NYPY80v0DygdCOAPZVOl
	 4/2a2EpFVbZvQ==
Date: Wed, 5 Jun 2024 17:50:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH iwl-next v1 0/5] ice: add standard stats
Message-ID: <20240605175036.0d0e535a@kernel.org>
In-Reply-To: <20240604221327.299184-1-jesse.brandeburg@intel.com>
References: <20240604221327.299184-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 15:13:20 -0700 Jesse Brandeburg wrote:
> The main point of this series is to implement the standard stats for the
> ice driver, but also add a related documentation fix and finish the
> series off with a cleanup that removes a bunch of code.

With the nit on patch 1 fixed:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

queue stats next? :]

