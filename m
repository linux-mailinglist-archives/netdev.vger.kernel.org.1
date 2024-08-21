Return-Path: <netdev+bounces-120520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D15959B0D
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC46283BB2
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B828C1917C7;
	Wed, 21 Aug 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZVCwzkm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6821D12F4;
	Wed, 21 Aug 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241274; cv=none; b=j4bUAH5gspYUvKwlB8WkOy+cw5/jfvmMa73dugYousPAArw6VPsSFR6xaO62qSb837WdtyYsD9PPRteFkdus8GLVhplkLE7fUPi1JnU31OlPLNteHr1AImz2zUm2X4wclaUOgjomN7bWOKs7qVSdNw1G+35lamfdLM07A1aLlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241274; c=relaxed/simple;
	bh=A6ezsuyQzgXwvmK16asLytG8ZfNhWWjrjBCzJL1TxUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cbwrw+LlRTFdMtE6MDKkdKjrLReaiJqnGD/7AFdTSb/FeqV02IhLeVvJo0HgwXq/1wQ3ZZ/HYYKxYpeR1p8YRcL5/ilyDOeLk2qu3t4+M3/FE1fnLXxjc/xGwVD5wYAWIX+EI+nPhQYXj9CYX0iHosJvAbut48jDYk+ogirFvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZVCwzkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EF3C32782;
	Wed, 21 Aug 2024 11:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724241274;
	bh=A6ezsuyQzgXwvmK16asLytG8ZfNhWWjrjBCzJL1TxUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZZVCwzkmnZR3MpmVHec0nbd4sddjrmC9rbnD8H7UOaMGSVk3urHVqTXFmjgHuVb4T
	 tybaKkSfPVVxCiOM32fh9E7UKHqATPv+kGaKBu6LSzjZFZshYwRHv0qwox9wmijt6V
	 8NXFA7cEAz/MBaX8lsLCDxupIsJeMyUUCScXdb24VsIb+vtpDGleW23LnB36zwIfrC
	 scyjEFiwXDqVJigoCInBcpyCCZC6LzJRkGpJ+TuWPLmVar3xdDn7xNU++xsa5udBm4
	 lPnf6d8JlsHPr6JddCpxi0etmdlQg0EzeBlnNlyFUrbfTsBOA0lGwMzuOsTw5Xzv32
	 XC7irzXCBV+lg==
Message-ID: <18c39aed-b8ff-4207-9b32-48db04c18f9e@kernel.org>
Date: Wed, 21 Aug 2024 14:54:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/7] net: ti: icssg-prueth: Stop hardcoding
 def_inc
To: MD Danish Anwar <danishanwar@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Jan Kiszka <jan.kiszka@siemens.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-4-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240813074233.2473876-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/08/2024 10:42, MD Danish Anwar wrote:
> The def_inc is stored in icss_iep structure. Currently default increment
> (ns per clock tick) is hardcoded to 4 (Clock frequency being 250 MHz).
> Change this to use the iep->def_inc variable as the iep structure is now
> accessible to the driver files.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

