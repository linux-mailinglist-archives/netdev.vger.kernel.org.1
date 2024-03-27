Return-Path: <netdev+bounces-82332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E1888D50D
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 04:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5812DB22DDD
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC66224F0;
	Wed, 27 Mar 2024 03:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ3eEOjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967F224DC
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711510096; cv=none; b=Y/S/lfb4cBnAJoidp6BnuG/LWfsnZcc+hJyNrnk25utr9xsAU6sSDZL9SpkC3Dne8kSw+v43/Kg4w404PoIzGQJSWEp0tyC9vhv2VcFag4qICqSuz6D5rTIGxos29zpW+NUk7l0SMcQoBFIOmsjDaDflEPrfyOFW7+AUwqb4s4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711510096; c=relaxed/simple;
	bh=+0xen8NUOGIO8QNlJF4kylCE8XJXbPLDF95nfnCb/n4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXmstpdQ1g6pOyhcZ7O3DWVR3zttlZm54TfFSGvGw/9Eivmkzloc760DEMByL6wA2dpjN/5VRDLPRZYp3EwSt11hnCWxMmhpSYOlNy7uI/INEvSJe9dujMgL+QijOcPbJfPwcAx1MTP+OGDORFb6ewzUxbEiuKM3C1dKhAiNJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ3eEOjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C34FC433C7;
	Wed, 27 Mar 2024 03:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711510095;
	bh=+0xen8NUOGIO8QNlJF4kylCE8XJXbPLDF95nfnCb/n4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iQ3eEOjSdpDJ3Ilfza+Ap/YF+UFCN6IX0YrOFswzewUTZP01JU0aHN5niWVBWrixQ
	 DzlWbfRgECHJpCGMRnGwy/bQ892h4hEcjuEQdwV4xUuNbW7q4azZZBlixbSkwS7c8c
	 x+u+tyC2FxmQ6VylxpyDlw6s9hkHAsSK52AbM4Vkdfxt1pvLzbxTb43bB37huWMdxs
	 FBEk2RkfizC8pKzR34h4Fkg5ziGBKpaL6exyVVtUDl5vJFee6OhCGNqgp5E4kvxZT7
	 CYntWw1TsHh0Kn3Tbhs3sjLwnlco3ezseAyL3wz91VaEB/goxiAno/fplNmA9saYg3
	 h36EFJlS3Fn3w==
Date: Tue, 26 Mar 2024 20:28:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <jiri@nvidia.com>
Cc: William Tu <witu@nvidia.com>, <netdev@vger.kernel.org>,
 <bodong@nvidia.com>, <saeedm@nvidia.com>
Subject: Re: [PATCH net-next v3] Documentation: Add documentation for
 eswitch attribute
Message-ID: <20240326202814.03c3b121@kernel.org>
In-Reply-To: <20240325181228.6244-1-witu@nvidia.com>
References: <20240325181228.6244-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 11:12:28 -0700 William Tu wrote:
> Provide devlink documentation for three eswitch attributes:
> mode, inline-mode, and encap-mode.

Hi Jiri, looks good?

