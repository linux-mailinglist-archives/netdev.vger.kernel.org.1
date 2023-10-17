Return-Path: <netdev+bounces-41964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA787CC753
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF721C20A2E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE8A44496;
	Tue, 17 Oct 2023 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqRAq7CI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888644492
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D4C433C8;
	Tue, 17 Oct 2023 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697556083;
	bh=qbYVXv4lkClIrB/LA3B8Jyjx9weJj4eJIR8Mx8PZSYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jqRAq7CIsOinTEsGUuo+mqcv9B0r2CXjADfQ4alGoVBKPa9EXx6j7ii9pwS8T5GPG
	 qkbsJP+Z4OSLjbPKwb8wVfJPScrt+g7RY9OnASGqa0oLI+nZudKHO17RTLro2tvQgi
	 0rKV89mkA2GAyutB0nvGmPm/sRzYunUVmCvxjSQIxxi4Fvi2/kq+rYObzQ6B2faq0W
	 5VM7d3/Nepn29SFzYmUMnxK4hFoZJkLRap/mNlicUsVCy22af19XxgBqmnRwefoykE
	 mbRrJNDRlnAkV3oOsPz2oFC+BUxqabo6WQYZwfoWk971qZN2ZdO9WZULka4eDX0liy
	 8MCb7vl6Iybsg==
Date: Tue, 17 Oct 2023 08:21:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>, Jacob Keller
 <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next 3/5] i40e: Add handler for devlink .info_get
Message-ID: <20231017082120.1d1246f6@kernel.org>
In-Reply-To: <b1805c01-483a-4d7e-8fb2-537f9a7ed9b4@redhat.com>
References: <20231013170755.2367410-1-ivecera@redhat.com>
	<20231013170755.2367410-4-ivecera@redhat.com>
	<20231016075619.02d1dd27@kernel.org>
	<b1805c01-483a-4d7e-8fb2-537f9a7ed9b4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 11:56:20 +0200 Ivan Vecera wrote:
> > Your board reports "fw.psid 9.30", this may not be right,
> > PSID is more of a board+customer ID, IIUC. 9.30 looks like
> > a version, not an ID.  
> 
> Maybe plain 'fw' should be used for this '9.30' as this is a version
> of the whole software package provided by Intel for these adapters
> (e.g. 
> https://www.intel.com/content/www/us/en/download/18190/non-volatile-memory-nvm-update-utility-for-intel-ethernet-network-adapter-700-series.html).
> 
> Thoughts?

Hm, that could be better, yes.

Jake, any guidance?

> > UNDI means PXE. Is that whave "combo image" means for Intel?  
> 
> Combo image version (aka CIVD) is reported by nvmupdate tool and this
> should be version of OROM that contains PXE, EFI images that each of
> them can have specific version but this CIVD should be overall OROM 
> version for this combination of PXE and EFI. I hope I'm right.

Sounds good then!

