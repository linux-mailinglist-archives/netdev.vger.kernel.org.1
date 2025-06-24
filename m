Return-Path: <netdev+bounces-200871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C172AE72B9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC024172FB7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712861FBEB1;
	Tue, 24 Jun 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bOH5kKhk"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22D307496
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805930; cv=none; b=iLHjUtqmSowPOtl76pYc0G9uPBejTsctT8jxWD6NhRLKJ6Af+/kdEe+ITpOYdTOSuLRDcm9huPQuIGc2WUOS9oUJnc6x5RlDNMedxn9lpxOfNURs6LFyYGDviMCtY526TSbZa9nyCHgGai+v3Yr0qffivncNHVApV9qREM7clY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805930; c=relaxed/simple;
	bh=rZzKLWBw0FWo2X7/CcQwchRLnCUCTitS4HSTx1kYRwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFf/aJj1d8WQZ5dDj/+qRLbiWNFm0l3DT7c8LR5E+Q9yJCGIwL8giT4OiRkmVjc7TfskEta5jd+qtNLlrJ48WxT1Z1Qaj6s6np0ZtdSg+fHfpuIGLzeV8IuG2I/dSCpuESUtytbJ4OzJ0BIojjv1z4rrAL+ftVweXW856mkV4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bOH5kKhk; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d20c4397-0d77-4053-8ff7-cb9af2d16ade@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750805926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Hs+NsQpOGvO0D7hNlf2RDWsUyM1/34CukSfzWwXw/4=;
	b=bOH5kKhkI+wa+VBwzbD+JqIuR0V/1sXGyfi4g5t9MroBntmUU/HRZLA17JPAxRAJFeenKk
	UveykNNXPZ6N8nUy4qzRyxk93n/sgSCayfkYwqadhF82iptY7HKZGAUgJKEBMFBW9m4iJE
	jW6zO3pmvCK/gUw78E0nQckZsrBGbyE=
Date: Tue, 24 Jun 2025 23:58:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 04/10] netlink: specs: dpll: replace underscores with
 dashes in names
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 donald.hunter@gmail.com
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, aleksandr.loktionov@intel.com,
 michal.michalik@intel.com
References: <20250624211002.3475021-1-kuba@kernel.org>
 <20250624211002.3475021-5-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250624211002.3475021-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/06/2025 22:09, Jakub Kicinski wrote:
> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
> 
> Fixes: 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jiri@resnulli.us
> CC: arkadiusz.kubalewski@intel.com
> CC: aleksandr.loktionov@intel.com
> CC: michal.michalik@intel.com
> CC: vadim.fedorenko@linux.dev
> ---
>   Documentation/netlink/specs/dpll.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index 8feefeae5376..f434140b538e 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -188,7 +188,7 @@ doc: DPLL subsystem.
>       value: 10000
>     -
>       type: const
> -    name: pin-frequency-77_5-khz
> +    name: pin-frequency-77-5-khz
>       value: 77500
>     -
>       type: const

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

