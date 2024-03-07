Return-Path: <netdev+bounces-78231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9AA874757
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 05:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAFA2827A8
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 04:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42047134BD;
	Thu,  7 Mar 2024 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJx7Rf1p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE9A134B1
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785646; cv=none; b=UtG3EPI+SGk0w9JZYBtkj6Xomkbyg46G9NSm0TjE/YZxVle301UGYnpGlXitSnklwyLX/oNPgJ3amyFg/EYw0t6nZpndLUC4Q4j9twPLbVQnamDfHjObD0VAKXAaCItv0JXp42lk15GJRjOBfzRKOyNPicFdJOc/INL6OGsLx7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785646; c=relaxed/simple;
	bh=dUYYf7FMWiEsPTitxBUiKmrzShAiR/rhduOsCeDF1hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy/9Q2k7e7MID+VoryJPbKB1bIytXbVg6+uROepUMdKXOkHcMTV2Gw9ULuqCPWtRPpdxRELM1I8NgKpgcl9SJrx8Gc63+cr/sEWFwnH9UQ9FQ3+HfZXigX6CB1Y+1Rd4OwDlnUiBlqa5dfiTjes+rg7PYBP2zTsfreSaki29NFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJx7Rf1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAC3C433C7;
	Thu,  7 Mar 2024 04:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709785645;
	bh=dUYYf7FMWiEsPTitxBUiKmrzShAiR/rhduOsCeDF1hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AJx7Rf1pFusHrQ4hCgHSXu6f7KRytISHxlyZO2NWqnIj7DQVJ5us4rJqjt7ZbfhTy
	 eEqnalKgDVTOkKP63HA0T0wY5jGR+qYqBt7cKJLIbDNls0aLRLv+3/mWYJbazl6vgO
	 OTn95GwgwZcS3vTKaupv2El+MppapdqRXasPIK8+RS+6XqvG7tD8DjqvH5qlZMMZrG
	 SoophBcdCnGTBihC+ELs8zh6HnsYz2IVU2U80e30qAba89v/j9iYGfAx+e3dUTluDF
	 q7YdyDirip81xVaOUqgrwR1gQGVn2f/7PLit7Kwve5aU1Xl7uFr1bBCD5aFBCgkQZA
	 DKPgqLCPf6srQ==
Date: Wed, 6 Mar 2024 20:27:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev
Subject: Re: [patch net-next] dpll: spec: use proper enum for pin
 capabilities attribute
Message-ID: <20240306202724.670fb304@kernel.org>
In-Reply-To: <20240306120739.1447621-1-jiri@resnulli.us>
References: <20240306120739.1447621-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 13:07:39 +0100 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The enum is defined, however the pin capabilities attribute does
> refer to it. Add this missing enum field.
> 
> This fixes ynl cli output:
> 
> Example current output:
> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-get --json '{"id": 0}'
> {'capabilities': 4,
>  ...
> Example new output:
> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-get --json '{"id": 0}'
> {'capabilities': {'state-can-change'},
>  ...
> 
> Fixes: 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

