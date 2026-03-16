Return-Path: <netdev+bounces-268190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIgZKPsluGmNZgEAu9opvQ
	(envelope-from <netdev+bounces-268190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:47:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AACB829CB33
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 956053030EAC
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AE63A0EA6;
	Mon, 16 Mar 2026 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsAAPFPZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021539EF30
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675621; cv=none; b=IOfZ4Yvc3UWwnzLeCNaInfujbcPkFSam49ZZBbNEQZVTsT4D/Oc7rcOwEmUSbS8eCPE0wgT2RpKhkw0tWwPh+Y30lZePq0dR/ggAG2c+yuMTYuAhQSFHED08/asRhY26A6IIBPZGDMYkMNN9SguKMsVdWMbr0sLm85+ByHjMjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675621; c=relaxed/simple;
	bh=EE1wdoRj0efEsQBfOGePOzjYx/KJqvc6+IwnVfX+oAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdqiubQNcthGzKFG8iq2kIRFwFKpTcZsTtXN5e1aPQa1ST/BevQk7csOHGaC+pcK5EutaugnupHSgXjGhP5SZiUNsbcEN3Cz6lq3JW+DGPY5g+VL0EwvibaFdN9GYbzQXyiaMOTYXjiswaGXiDKKYD2RO5Js2tlsCUMdQ5FNw54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsAAPFPZ; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12732165d1eso6044086c88.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773675620; x=1774280420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5Kv37lWGfOk0PsCgIE5EukMlY0TUTeBeToxWLNzU/E=;
        b=YsAAPFPZ/Fcv5QlMM8KXetnmLSrxwpSvEcqpK5zrpXpNHXS537nZGMWeIzl94ANeKA
         WD5Qrqw+eiDJeEQmXLXYVashwx7VRiILb7I4opEqLeVkeNSgYetKVEFm+ZzQttHRED/1
         rEwQ3yOxI5SxESWr/iQ5hvQdujnoS80IRG/tSw7Rev+6ZwhYDZj/dj0SzRgs901RtsT6
         TFt3o0G8ebsD8izSlCVoFfb1Qkem6ll7qAyPz4os+srA68Hp1cj30sypdLB6L7iuuqPz
         gPKeY1rkYfVUuclM7n2TtAJXDFalkF9x5hVFOKm++c/xz8tr7kbVxpCDu3aArBWQ70mZ
         K2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675620; x=1774280420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5Kv37lWGfOk0PsCgIE5EukMlY0TUTeBeToxWLNzU/E=;
        b=HKrm+5/MCcVYQebp42dPhEn1/ZhCiO+TojyACjO4nxC2ZS9myOaMBQuS7auDXomK6O
         NvDbsItLoaikK/phW9JfejgqcLVKheZE2LU+fguRbZP016/MRjtJ8M2hZLVBBeAqaHDu
         eFIaf6e2yWyD42QPbM8usnDcQ2RYmAFTh7TRqZbXOhIuekzaQ7Z+Oik3RYxNYwAUOeEt
         BIRAGEnasqADaT+0JpK33DQSXxjeOEL/b1rFvFkcoqpxR9mA1Z2dUd2/v9S46BCJPxzE
         KeQ9cZ3ztUIvEKpsFl7phCf/8oizpVD89c5jinPvJsL9ZZSwhDKt6mlEUIyZdVdzkWua
         erzA==
X-Forwarded-Encrypted: i=1; AJvYcCUqrgYyxuWLxxDoWEotrFVPgVS+I1e5urrfkUoLxX8adyyz/f6ibZ/CiCGUKhsQEwdWUJDrJLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHxT4SiDLHNipzl4nb9skXHG1fae7msqkLakyc02WG/aAX08tN
	yCO8VR40KWksvIhccI202RUo2kfbO/tIWkzes//1YaYlO5woqLJz2zE=
X-Gm-Gg: ATEYQzwML6+6A1jW9xVAo7fblaNl7+HyIvbbMBq8fWXmfDMd71uYd81f3dPghel+J45
	71GiLas5lO5o5+Q/njmkO7jFOUY5NRjDXWiE9lvaonbrMAwFo6i40JoN0b8R5M3HuJ9kpvzdFMN
	3gBo5Oc8pHYbIBlkXNIhMlpRTZbc7VhjuCCx5EVdnGYbIm182XYQAydWCN91649iqXzVG2g56i1
	yGwG1WlaaWUH/w3vybyezZWx4M0SlJ7oCeIbqdMMIpXUvSm7rDBjqVE4FnJy7vtdP5TsV1SonQ2
	SSaVmkRH4LqpotvgamCRutBAMXo1UYNcahyXK74YG5SYE8ZeEjrzTgGXa8oMEJl1jn2EaKTjeuN
	PPi/xfn5dlygH8AG/2OfVFVKOpfoi+sKGzjx8+2wAFs3uX90PnaULwCqVdGnY44naHglqDpK7C2
	RDcJGRHNBfBm8S6jaznW2YMcArao8w9lEXaYXCp5Bdv5NsagwReODcirCx8KfyRoThbaIOipNtP
	4392TaYPIqEq9QSbwbVPvn5vRcM
X-Received: by 2002:a05:7022:688a:b0:128:d7a7:5271 with SMTP id a92af1059eb24-128f3db2aeemr5827345c88.28.1773675619619;
        Mon, 16 Mar 2026 08:40:19 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384e7asm11945471c88.11.2026.03.16.08.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:40:19 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:40:18 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
Message-ID: <abgkYn1p-Q78H2W-@mini-arch>
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268190-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: AACB829CB33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/16, Maciej Fijalkowski wrote:
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
> 
> Adjust ZC path to follow the same principle.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v2: route patch via bpf-next, not net-next

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

