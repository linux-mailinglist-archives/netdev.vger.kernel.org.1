Return-Path: <netdev+bounces-50245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AC87F5056
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 20:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5E21C20AD7
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC105C914;
	Wed, 22 Nov 2023 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq75cjTf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF875C902
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 19:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E471C433C7;
	Wed, 22 Nov 2023 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700680456;
	bh=3uUNLffVdKPjS8Q4KLxSXXCEhTPX2bXSPf70fTAieZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eq75cjTfd5GJ+DsSDsMy2Rtc0r3643pav2O6pLdTtCoQykMBgLm/fwbXdRQQOgUB9
	 n7r0SEHPZfbm7pyL5PiDzqn6heLXEjfXhIlz4bRpnt93QzcFX6zElk0LH0rQyCFypl
	 Auz3u/lkSBfOyJJgqa+KBh/6zIsu8sZ3VQsfH8iaNIzUl/Rcxa2FzTgcjpra69U6Af
	 EMlxFZU4YzYmx/rUZEGq9OAelFsrYwORgFsXMpxdEeas9wo8F9IE1MPZV5YPSH9YAL
	 T/1PDJ8wMnnjvIxP/0uvG7Mp9dB7khzq/oxQTD78bw8ld5FCgNYuwR0HzndZVX6TEC
	 kjPFPZCnB7xig==
Date: Wed, 22 Nov 2023 19:14:12 +0000
From: Simon Horman <horms@kernel.org>
To: Pawel Kaminski <pawel.kaminski@intel.com>
Cc: intel-wired-lan@osuosl.org, netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-next v1] ice: Improve logs for max ntuple errors
Message-ID: <20231122191412.GC6731@kernel.org>
References: <20231121013206.2321-1-pawel.kaminski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121013206.2321-1-pawel.kaminski@intel.com>

On Mon, Nov 20, 2023 at 05:32:06PM -0800, Pawel Kaminski wrote:
> Supported number of ntuple filters affect also maximum location value that
> can be provided to ethtool command. Update error message to provide info
> about max supported value.
> 
> Fix double spaces in the error messages.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

