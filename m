Return-Path: <netdev+bounces-104957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72590F49C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FC11F23334
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44700155336;
	Wed, 19 Jun 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSNUoefd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549B154C10;
	Wed, 19 Jun 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816388; cv=none; b=lrzPrr0inVQbkv+qc9rArVv2DtdPI4UYMa753Fg1KlW0WUcCrXne4rGQEJsukzjwebzF+lvpgBsE62VA+FcFaNG7fmkMjGsX8bdU1tn4TmciSxINJ0cEr8V5ONa46cN5uIJVc4QUV18Fhnvjc9tQk4tK8SERtwGK2WRoEemPCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816388; c=relaxed/simple;
	bh=ozx46ptys4WBFC+qPdiQXsIwwqMhreHKyQAVUxKIpJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7hf3HS1NVFqXXJYmRO8gl5P6SJYvrKIa4duSN8/7RpPolwT+ETKBHt6bp/XQ5xKj8IP/HCkYzYfi/u+bZZyCf8BQ1VuJfrChytzq6omqS/uKuCRl2Qjgg8Vdo83+KNmBRoLcZFEoauxpl8ZoXyrOblrjU12ffMUzu8rrxiXUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSNUoefd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE76C2BBFC;
	Wed, 19 Jun 2024 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718816387;
	bh=ozx46ptys4WBFC+qPdiQXsIwwqMhreHKyQAVUxKIpJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GSNUoefdPCtyNIcXaKTfPF0zzzKYbGLCZq4WE8opW/PmcBgls2Kdv2crImG6tmpPj
	 NArciQNCiDtTTQ0gO3PxFyNav1eN04AS85lYpn5SGach2DjBOCqtGk0gCK9tepkq5K
	 5iKYFUfiitWYb7oNZ6AqyC3pOID2WRxXY2PEVzbgb8iWuqHgSInLEf9n24avr8L4Pv
	 XMUcmjcxczB0pIM0JoWFM2PuHJ24yPTp8u2NTAN1M4OkNhX3FPu19K/8sysIwyCVcW
	 VEODUhRTgehbs/3MAqKCEkNlm7eGFDmILeXp+eOaeO4kif6lnOh0jg0HYMtJyuGEqj
	 NkzblAZQHKyTw==
Date: Wed, 19 Jun 2024 09:59:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH net-next] docs: net: document guidance of
 implementing the SR-IOV NDOs
Message-ID: <20240619095946.6058be0d@kernel.org>
In-Reply-To: <BY3PR18MB473780CD47EEE6E4456C8169C6CF2@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240618192818.554646-1-kuba@kernel.org>
	<BY3PR18MB473780CD47EEE6E4456C8169C6CF2@BY3PR18MB4737.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 16:37:02 +0000 Sunil Kovvuri Goutham wrote:
> Does this mean 
> ndo_set_vf_mac
> ndo_set_vf_vlan
> etc
> will be allowed for new drivers ?

Yup!

