Return-Path: <netdev+bounces-182029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF602A876FF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9634163EAE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 04:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF019199230;
	Mon, 14 Apr 2025 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="YKQ4hnXo"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32293FF1;
	Mon, 14 Apr 2025 04:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744605542; cv=pass; b=Gxv+RT+ZKsXWOxJzpowGuzj1+pfmQtO7Zupp5VpxtrbxH5PiJB01FjytHgw2Wnbeu3ypwFQ5hPOfmXCjo2d5Swr4cOyWjFJ8+TExWKND+xJhjlFcA/N07tQfy03pJFnvjLzx7H+m+icBSW2GmHEhSjVckeUta0IQrkoOdEHnBp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744605542; c=relaxed/simple;
	bh=revkaF5jZeZ0D4TMUY3medQgAbQjvH1GxuuwuJDs54w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhp1Tdo/9JELQewDXXPzZ+mOl/dpMWhuUpAyh+gvbx1cXYUfHDl6TTFOCUuCwkUF5KenQgjyx0zGhb9qvO75V+xuPw3Ah/M0fwKuRNnNTBV0wbb8FUVrlhBSI6Chcwn6TWTT1nGGcnwJ7PkeFLUFMYSB9oDwFDBF2k6ZrtjD7Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=YKQ4hnXo; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744605524; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cxsbN5I+FD/f3hzAXVDMR3yruvDtVo8P/ndb71+diOFSVhAWr3dBRAjYvI9q8HBtDGPOgYYOBZfniqatPi3mGXWHjExt7cdNTOY0bIc26HcYZalQWt02yeF1E/Qp8xr7kUH1/EQjTN0hYJdFn8gcrNAe15vObUFrF4LEGtvq2Wg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744605524; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EILnKTFBtT06iKZc5zhyMS+LeBMEqFCBv0ihJOCmGQc=; 
	b=Vt4Z2/JZhsd0+PRZmM1koLbREwIlpRCrZMTHH5Ta3l7YO9f1oy7lHTOMdv8XMqlHZbWsT5XHKvh7jix87XfRQqzRiOQoaHBnuMBuNMkH5RmoU19f6FLQrprz3lchdst4aPjsTGG4p6wtaZrEvXQwq57cy69+lvxsvm53z/ogGPA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744605523;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EILnKTFBtT06iKZc5zhyMS+LeBMEqFCBv0ihJOCmGQc=;
	b=YKQ4hnXo9qyVlYaC4bcsnpMy1XKXiETTBKFrIjFH/D21NBZ7t0hgtfRViHJKuQTe
	ZGs+UlflXt5q/gxaHA3WxSGCWVWsMyJXCUUXDTbDLmjcCIZAXZcnaEYP5wTBmabGIqI
	sVxwDo8z1zX3L4/u+GoL+KmjoLfA/85YTUoDemf8=
Received: by mx.zohomail.com with SMTPS id 1744605522312493.91832637456594;
	Sun, 13 Apr 2025 21:38:42 -0700 (PDT)
Message-ID: <0d62e6b6-0535-4157-b742-d6a608b776ab@collabora.com>
Date: Mon, 14 Apr 2025 09:38:36 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/15] ice: make const read-only array dflt_rules
 static
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>, przemyslaw.kitszel@intel.com,
 kernel-janitors@vger.kernel.org, Rinitha S <sx.rinitha@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
 <20250411204401.3271306-12-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250411204401.3271306-12-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/12/25 1:43 AM, Tony Nguyen wrote:
> From: Colin Ian King <colin.i.king@gmail.com>
> 
> Don't populate the const read-only array dflt_rules on the stack at run
> time, instead make it static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index 1d118171de37..aceec184e89b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -1605,7 +1605,7 @@ void ice_fdir_replay_fltrs(struct ice_pf *pf)
>   */
>  int ice_fdir_create_dflt_rules(struct ice_pf *pf)
>  {
> -	const enum ice_fltr_ptype dflt_rules[] = {
> +	static const enum ice_fltr_ptype dflt_rules[] = {
>  		ICE_FLTR_PTYPE_NONF_IPV4_TCP, ICE_FLTR_PTYPE_NONF_IPV4_UDP,
>  		ICE_FLTR_PTYPE_NONF_IPV6_TCP, ICE_FLTR_PTYPE_NONF_IPV6_UDP,
>  	};


-- 
Regards,
Usama

