Return-Path: <netdev+bounces-277502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEMoJh862WnJnggAu9opvQ
	(envelope-from <netdev+bounces-277502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:57:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B983DB421
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29E993071033
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562F9230BE9;
	Fri, 10 Apr 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="txTxegbb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61E4A35
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843592; cv=none; b=Nah5OYgO5HEdXU0YXZpvDPene/nARuDfLDUTLct2RFtpyz917YkofeQnYLJYft0kHhQXHKNnrzKaZo3Gy2aOHsgXYpw7MLtNAUAYKDmtrBpL5yD6CQUX7l0bqgAmwjQ1tbCZN/FucfRoz2ahKIxj/yP7BQ3X8O3d92d3QxTo9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843592; c=relaxed/simple;
	bh=r/0pI3adLTYipWIJZGVAzMWqmoyRaJlcU5HdIEE5Y80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lol+sKGNW8cjItSjyNLd9mhcIgINJbjZDFbinNiNKGEub+XWFD4RNiV0jpk8qT5hHuUJTEg1nMV9oaiNp1FGbJiU22kpqIkXBdfHKAvQYUE9DtYerUC6FkLAHD/RKsV5dxX1FDDqbq3RA3ytoFup2YyCbRnzFoOrZ1nYEmeWdZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=txTxegbb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c766cf593daso1610115a12.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775843590; x=1776448390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sq+y/9byaIkL7h6Mh25RQ0k7WMeVVSbAl+IgT/3yRhM=;
        b=txTxegbbqK0fMAeuSYVBEdtY/VwXthUywF4NvAVH4jTDsN+LIIS/TtAI/uNRu9+xGW
         UwkHKH2Ciq8JX2skSigX9mitLEcGNInpkiA7XiHyzO7v0WiLvSnP5ccfOb2HvDK2uS+2
         EJFXE14LyG8SvvOw1saXLoqAK/ZVkK+f41RVyUW3FS9VgqIxpRrkKA+dp1NXQNM1ESIN
         8kMR7+C5tZnJuPPwHHJiKfc2zf/C4W9metlet+IqQIhFjNzvmjgV5AbCYe9RK5PQzvrJ
         llWBbt3K+Z0wGb38x+BdVzuS6M681LuRxm4scvPhIK39DUUXI7vNaTH5BVjmNjLysDZy
         J8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775843590; x=1776448390;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq+y/9byaIkL7h6Mh25RQ0k7WMeVVSbAl+IgT/3yRhM=;
        b=stl0pzKGPPFeoIMySZ1dZwpoWZYZtMIFxZpYgSbGeCrFz+/IdMemxzKiDhkFl1EWYG
         9d5iQQiFXNX46GEadYSzXUH8R7Lsm04P5xwW27xIGgEYMkDgg49llgmXbSZe7yLEhwAS
         3RzWS2W/m6yg4UBX/tR4IlpRzJZNBGMXVropScL1x0d9tQTwwNJUTtNiZJ/AwfoSEWw9
         fott5huwO9xIuGm6P1LqH6V4TpiWtyOKVLEpm9gj4kKl073HqdtaYFPTtLlb4LjqtpEo
         Q29bYTYmVZv8JmlRMyoUTwMeVl8Nj7HBqbZxzYm8PzKoSltqLwjBTvafr9dlhEB2lky2
         x7PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIZPHl35VrSPkAXXOAN6eX+a9cUhRIZWSMS7SuwItm27+Xc1F2A+LlcJggWb3X65L2gEA19j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHfEHFbGB5JnfFKD9ka+TdTTm74sZ+xXZp7AL//iZjsvaRK1m
	W/jHgX+cjRkDrjwka58c9aBpDGi627i6uayIudnpLMIdnfxcmC+wjXrr7FaFYdfI9qmpEMSOadG
	8LHHh
X-Gm-Gg: AeBDiesxEVkHFabSnLiSrpt2iG1m6XL6YakMx9BNX3gvJrToAbK3FJAdJP4bC5Tknmz
	xNr+vq0P4wlCsfBi6PtCAZG27IukSLVGZTPN+f39H7JkU6Adg8u2q76/j4mWL1Mmd38KpPwkHJ5
	HZkKQinyLSWYT6V5Af4pSXhCQXx8z834ffJ3Vs8cOCd2QWtw1cXqFm7CdCy3hSxjTa3qUKVAa+x
	n7ycdIpqpihQurbHV+Znphw6DluRlGx7+GbxkFGUL9nSVGHkSPaCkbeW+G2kw8owfBxyLl8+fsJ
	gsUNQ4ageVbXZgjcrZTLwOw/uZtGzuSuZJZRQXDB2QO5/M8JJItsSpkYDp5B0eiH0Zw8wDc6ZUO
	ifqr+fbcTzLJa0exXFXVU9f+nKJcpYzqp2K6HDkbCl1pmVIMDzOPrGEHyfb2ugUIFVexzjmWSa0
	2M7m95HUSbaQtafVY=
X-Received: by 2002:a05:6a20:12d0:b0:39f:794f:94d8 with SMTP id adf61e73a8af0-39fe3f49777mr4765807637.29.1775843590350;
        Fri, 10 Apr 2026 10:53:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79218fc7e7sm3005525a12.10.2026.04.10.10.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:53:09 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:53:09 -0700
From: Joe Damato <joe@dama.to>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Leszek Pepiak <leszek.pepiak@intel.com>
Subject: Re: [PATCH net-next v2] iavf: fix kernel-doc comment style in
 iavf_ethtool.c
Message-ID: <adk5BS7W24iwY2qt@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Leszek Pepiak <leszek.pepiak@intel.com>
References: <20260409093020.3808687-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409093020.3808687-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277502-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,dama.to:email]
X-Rspamd-Queue-Id: F0B983DB421
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 11:30:20AM +0200, Aleksandr Loktionov wrote:
> iavf_ethtool.c contains 31 kernel-doc comment blocks using the legacy
> `**/` terminator instead of the correct single `*/`. Two function
> headers also use a colon separator (`iavf_get_channels:`,
> `iavf_set_channels:`) instead of the ` - ` dash required by kernel-doc.
> 
> Additionally several comments embed their return-value descriptions in
> the body paragraph, producing `scripts/kernel-doc -Wreturn` warnings.
> Void functions that incorrectly say "Returns ..." are also rephrased.
> 
> Fix all issues across the full file:
>  - Replace every `**/` terminator with `*/`.
>  - Change `function_name:` doc headers to `function_name -`.
>  - Move inline "Returns ..." sentences into dedicated `Return:` sections
>    for non-void functions (iavf_get_msglevel, iavf_get_rxnfc,
>    iavf_set_channels, iavf_get_rxfh_key_size, iavf_get_rxfh_indir_size,
>    iavf_get_rxfh, iavf_set_rxfh).
>  - Rephrase body descriptions in void functions that incorrectly said
>    "Returns ..." (iavf_get_drvinfo, iavf_get_ringparam, iavf_get_coalesce).
>  - Remove boilerplate body text for iavf_get_rxfh_key_size and
>    iavf_get_rxfh_indir_size; the `Return:` line now conveys the same
>    information without the vague "Returns the table size." sentence.
> 
> Suggested-by: Anthony L. Nguyen <anthony.l.nguyen@intel.com>
> Suggested-by: Leszek Pepiak <leszek.pepiak@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2 extending the scope of the changes to whole iavf_ethtool.c file
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 103 ++++++++++++------------
>  1 file changed, 53 insertions(+), 50 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

