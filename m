Return-Path: <netdev+bounces-270798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIF2OoPDwWkHWQQAu9opvQ
	(envelope-from <netdev+bounces-270798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:49:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8822FE83E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01A25301A333
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F085B29AAEA;
	Mon, 23 Mar 2026 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="sSBi+3Fg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C5C154425
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306177; cv=none; b=R2v056vtS08CQq4KwAtu2oBE/xypn2zrQr7tGutmXBo8LCfgwVOFFsHCQu9ANvANQcm9SKj+G8+H+wi/MbNuar3E4kh7atH+mWS508BZ5mOXk5QBjYENG51MtpIkudgxYwGX7EZ5jdRbA+sGf9QHyZgtT+TQR8Ney73qSfZZ3Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306177; c=relaxed/simple;
	bh=I+S0Y4Bu4mQfuiLAX1cJEjk4TPWhW37pAs7+jdPjdAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+Sd5m4pbWYD3HDCnufSQjULidPAkZoQujXKa7n+qREKBZo5jcAVAPCKkhLjY84PdKBfR4TtmUMFbgYRb7APv/DIZK2hVJ7S4K4G8k3cJn9ykj8WaPawzLPSPxBuJWBCqF3COp00f/zQadmEJ10WZkl8oW/VsI3kcf5IYHD36xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=sSBi+3Fg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8296dabef74so3982745b3a.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774306176; x=1774910976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=096Np4OKL8mNrGXzkOzGuqkDmb4xQw5LjvKwCTOMir0=;
        b=sSBi+3Fg/k3ddGECTr5SaOpozrPeX4nqJN0i+dlvvHtbF45yXfIkgHTPMShV9+1VCs
         YAwyM43fh1nB2Zmpr2K/QADKdUT0dg5PMOONpeL1SOAb/1HgB70HnhQpqLP68VAqvHu3
         4nAjvKobx5xcVJu2LnJ0z3h4CARDytYrfONAIhO+qvOSCoCUZ1oUg5XsMQh/Xj3VgpaW
         zr0N0BO3AjR1LyUfHmKMISVnQAdftDhxueYuMUY07CC3LZpSa8BZ7Qoo/qFZFsb6SRg7
         t+2ZzTvjQY4Axbfu0QyMDD4hyn3SwOHge5nJ+zX19smEFvtawaQPfZ5vO2bMzN6WajPl
         62QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774306176; x=1774910976;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=096Np4OKL8mNrGXzkOzGuqkDmb4xQw5LjvKwCTOMir0=;
        b=NHQLWDdOWoYH6l7/snr6Djohoxem6sj5wFcC2gRH2FW78LGkaDE3w4pinTuGRgOHuN
         erXL8BCn3R77/oSebY3m/0uOe2RIK0RNUjlDoXlyFfmLvHGwcnBIwwSA88W2QH+QKOX9
         XJ2m8VFlLgtSgIJTfXgfVrpuclE24PACdiqvDGgxsiOr06R9MGnp1rvz8F74+h30p57i
         LV+QgZlCSIACRJOa7cV9P44RfuwqrJAKag9fK3PgFN7vBskV97/lxzwk7qYjkxeGCU4l
         m7+/Yw4PhKsaw2sLuEE3j3V22xAVZsfDbKSzocU3arnJ3iQNtc0ecUx4S1+ubLEi6SuS
         bzYA==
X-Forwarded-Encrypted: i=1; AJvYcCXSTZ1/21ga3aoBsmfbIyWCICGGJWXXCEhRoV5tsg0ZA9jE/bjjAD6xjilRUc5IOFwwYFxhwEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNvy+L76T1Qu3cImWgIzMg9wLhcSHI8CTfEpxNxlgiss6kKQm+
	gtfOeJHGN9llATezR6rIywZKBhTv3vwFs5VGefzCGYYNu435/tCVBjGw5O2cIS8rP4WvDg/SJm2
	PyaQf66c=
X-Gm-Gg: ATEYQzx04ek02QbDrV7qr0SbFCWowKdkz2W8tp7I3xFWy0N3hghL5+OYD4naSeUdp1U
	CDU0jb5WvurtWApxyn+EV6CmuMg5OYZ/yYIMw4CyRdAi1fb3ujwcIN8sNBcq3S+gHN2NJRy3v+N
	q2ULwWPBQyNaS+q7pl1Z1HinzPMexhgbFAEahqVjG2RQL7M7r2u/FXg43f6eXJVfm4WW7KZox21
	9dvg6aF8hOZvhB3liPNl8Se1aG1z7UEo2G5+7wjbGcCHZykBLtrVV11rpGjfc0U1Zrbeo0vmMMD
	4inD3Xhf9NX1jGTl3E/yhaS0wt95Cb+PPi6o6P9u05iTGlMkn0eAcs7H2So5snjN4U4lGXMlKT3
	xQXXZxAAbdUtVGx+05h9dpI3QVVoXOtBtFjnZG2uMMOlLUUK5AjhCmbuPtwrytxBLhvcLAoMfb9
	ADLzGt
X-Received: by 2002:a05:6a00:3c8b:b0:82a:768c:9a2c with SMTP id d2e1a72fcca58-82a8c23e434mr11786207b3a.22.1774306175908;
        Mon, 23 Mar 2026 15:49:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409b455sm10515326b3a.28.2026.03.23.15.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:49:35 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:49:33 -0700
From: Joe Damato <joe@dama.to>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
Subject: Re: [PATCH iwl-next v2] ice: remove excessive memory allocation in
 ice_create_lag_recipe()
Message-ID: <acHDfSbnc/f3nkQf@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
References: <20260323095056.3298435-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323095056.3298435-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270798-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama.to:email,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8A8822FE83E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 10:50:56AM +0100, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> For some reason ice_create_lag_recipe() allocates an array of 64
> struct ice_aqc_recipe_data_elem elements, while it only needs one (1).
> Fix it, while also using kzalloc_obj().
> 
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2 remove 'Fixes' from commit message because it's not a critical bug
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index 310e8fe..70357dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -2418,8 +2418,8 @@ static int ice_create_lag_recipe(struct ice_hw *hw, u16 *rid,
>  	if (err)
>  		return err;
>  
> -	new_rcp = kzalloc(ICE_RECIPE_LEN * ICE_MAX_NUM_RECIPES, GFP_KERNEL);
> +	new_rcp = kzalloc_obj(*new_rcp, GFP_KERNEL);
>  	if (!new_rcp)
>  		return -ENOMEM;
> 
>  	memcpy(new_rcp, base_recipe, ICE_RECIPE_LEN);

idk but should this memcpy be updated to sizeof(*new_rcp) to match the updated
allocation ? feels slightly easier to read (vs knowing that sizeof(*new_rcp)
== ICE_RECIPE_LEN).

either way:

Reviewed-by: Joe Damato <joe@dama.to>

