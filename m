Return-Path: <netdev+bounces-50784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F67F7236
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B467B281A4E
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 10:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC911A278;
	Fri, 24 Nov 2023 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqcNY3E8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7549467
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 10:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B2BC433C8;
	Fri, 24 Nov 2023 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700823582;
	bh=gaihbOYsDjJEzW3sdoefJ8zAs95axkC8K2co4ZBLBTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqcNY3E8DvTKpBjFL/rV7BP8xneZKn8npARXPXAIrsJerP33mzqfh+4pgp7JDbs+2
	 snPlUXpoY0nG9JCDBJieA4WgXPDX5UlE4RalBMqFcb1+9u9HQ6v8QC0q3YpeqeBCGu
	 JATjknuZPT2CQDTGqwpLhC86vAzYhVWAjBjWDgIAOg63cVE70D8BjogyeeKE4oK6Hy
	 fWFSKFayVrdLsQ4f8ezReCrC/p6A+mPPKz1H4r8z+JFPY1w/cvAE4hg17pBWiajYRt
	 48CqMfUzoc82a1mws7GaicuqZ1V215xjMRB7sflLUShbL8m0XAI8uw6EkLOwUNmSpL
	 KyDvY23uI0FhA==
Date: Fri, 24 Nov 2023 10:59:38 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v1 02/13] intel: add bit macro includes where
 needed
Message-ID: <20231124105938.GB50352@kernel.org>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-3-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121211921.19834-3-jesse.brandeburg@intel.com>

On Tue, Nov 21, 2023 at 01:19:10PM -0800, Jesse Brandeburg wrote:
> This series is introducing the use of FIELD_GET and FIELD_PREP which
> requires bitfield.h to be included. Fix all the includes in this one
> change, and rearrange includes into alphabetical order to ease
> readability and future maintenance.
> 
> virtchnl.h and it's usage was modified to have it's own includes as it
> should. This required including bits.h for virtchnl.h.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


