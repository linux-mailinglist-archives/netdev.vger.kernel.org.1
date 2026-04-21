Return-Path: <netdev+bounces-280141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDEGCiCG52m+9gEAu9opvQ
	(envelope-from <netdev+bounces-280141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:13:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9179343BD42
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 485E530511BE
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD663D6CC8;
	Tue, 21 Apr 2026 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHuu3LiF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80D39D6EC
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780687; cv=none; b=BZ0gXBQLaEbWTzgLzYFRn96S7nw7i49xh/2sLST1FxbeAedHaDnScAKPRMfAjvs0BFHXVs0YGikW7FM/cncfdW3SMplVzWmfBLm4pZZjpg8iEG7u1xMY/MoJMbtE/N/9cMR7H9JF19y+76cYsFd6KU3Trq78Ayi32na8aFLBAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780687; c=relaxed/simple;
	bh=oWhBQi0dVg9q9iWH6aPKcW6xEEJauwkpkT98oz1lMCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYs691B4UauEbMcJnc1WtJQue4yh0LobCUzK1hdir/llaxbaJCj5pGEBrraNsqKTcVydvREOEW4plMQ6ohyXaobL+U7xnsGDKBntT3nloDBOMcjqWWs7YIFHXPjE6anfPaIX+ZprBLt5AgCkHb1EURLXlovuhTCguIgap+F0s7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHuu3LiF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48909558b3aso33952445e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776780684; x=1777385484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7etYbCYxuIPhBEjwc0o2zhfDIbslFF/VqaAfxZBW2j4=;
        b=UHuu3LiFI0FrqSl2o8AdH9+Wbs1im8ccwRBe/3edDzcIKSujUKE+5uJ7ts2Qwwb1wj
         Fx1chwJNONn2A9XLzO/nt3m5p/V2/j/cvwSiSp9UKg7vEN7wWssTmHhvQeN4L8dyEJqO
         kQHN00Ycofkva8MsT4qTrjLz1S1k3vo5plR+7ZrsbRfOP/eie3KEbBgTbD1ucg6nfhI3
         f9XvbuWrAnjsmRTLkJ66/vPk6EC27ng8sU8kUmKCeY6dCQujBy732enaS9xtp2FORRrS
         MXKptB7KbVdogeoofCU50bHYoO1TTmyyQVANyYXZpdoBgj06Gq47lHjosz8YsCLD9gnH
         dGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776780684; x=1777385484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7etYbCYxuIPhBEjwc0o2zhfDIbslFF/VqaAfxZBW2j4=;
        b=FG5ExqOU/A9vE6ZpBG5R9Kfd/bRmu+czpfL6e/pv7BOkKSM07oyI63lisSTEyfavBi
         iZq2fyrnwFPUzpc1sH2sFm0c3SS3QXfTYB0NA5U1lMm60Sxwk/N6yc2covaSn6saX3VH
         1jdAph4kiWAahUvo299Wn2jyjCkMdTGRm3hpAfJWVesRbKvqV6Pvjc+oSOYcbtF2tL1q
         1rHuySxV/j3aql80CMXyg9UXln+gpAnb2cB2GCllOAK+0KpVPHlKM5xX+Ei4QrK5l8z9
         wp65bC2TA7OcZvCKtjRQY6Zg73jZwkeydrQlatYFQCFmiyrHVz5wZCzH0/KKOJfhfApQ
         rncg==
X-Gm-Message-State: AOJu0Yzc/fVatM/7Z+TF+V5NLQXvIfI7fM2v476ZD6MgzeAJnbfVZgdr
	xZVwuP4UG2rxcDH8mtyRABdTmFGNhnhyYQOoRPCQ3NDvkcEqllkJCqug
X-Gm-Gg: AeBDietj7pvFe99aWVP+/1UIziOLolK6uMiVrzGogH8Gmr+8kfBOGdyD2phx15L31x+
	18+un7G1O+5bg3x/ozFLvCC1P9ESYEwyplCq70jmDCydQ3Ph1yjustIhLwg+VEfmzjD07sHe0qp
	crf5TVyTYrI595fcHZAAu8ltLw/jEop16JYlAcMvMdTvUKe616KpRKtNSp4rw1OYg75O4Yk0eP3
	eCMYSCjuRdSElW7pkEhb7pVRoryWEyY33fwFWB7imYI0s/lKfNzaAEtGhHgFmOdso3HxatVk3vo
	YcydbN8M0Jmac6fKjCfW+BVlF6gGLA0jwCIq28jruALufBC+DX3twLDX/Jz7HJhryzZ4syny4CY
	EMdCq6sqCucZNEDnhGJ/Sdo6KGLA7Q425UX86pjaD+53rR47znw3TqB0MtS3yTm9nV5fZVzR/wV
	Uv5yLaXAJLuE/YvhtKUMyws1y4DgfWVQ==
X-Received: by 2002:a05:600c:4e4f:b0:488:a2ac:a34c with SMTP id 5b1f17b1804b1-488fb7433ddmr262988925e9.12.1776780683861;
        Tue, 21 Apr 2026 07:11:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb767961sm112173145e9.16.2026.04.21.07.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:11:22 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:11:19 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/intel: Replace manual array size calculation with
 ARRAY_SIZE
Message-ID: <aeeFh1zQqhVysvxI@stanley.mountain>
References: <CGME20260421114034eucas1p1d746ffe32b49aeb57f10e729d1331124@eucas1p1.samsung.com>
 <20260421114029.2689961-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421114029.2689961-1-j.raczynski@samsung.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280141-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9179343BD42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 01:40:29PM +0200, Jakub Raczynski wrote:
> There are still places in the code where manual calculation of array size
> exist, but it is good to enforce usage of single macro through the whole
> code as it makes code bit more readable.
> 
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> index 1be97a3a86ce..0e7cecd00169 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> @@ -109,7 +109,7 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
>  		-EFBIG,      /* I40E_AQ_RC_EFBIG */
>  	};
>  
> -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> +	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))

This still isn't beautiful.  There are so many parens.  The !(foo < size)
formulation is weird.  The cast is unnnecessary.  Better to write it as:

	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
		return -ERANGE;

>  		return -ERANGE;
>  
>  	return aq_to_posix[aq_rc];

regards,
dan carpenter

