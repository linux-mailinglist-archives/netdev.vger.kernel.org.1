Return-Path: <netdev+bounces-80097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E47387CFDF
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 16:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C041C2258F
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD12E636;
	Fri, 15 Mar 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGZ/tOLV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918B3CF6B
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515567; cv=none; b=mAb8qV/EUndsM0sEJpRGB3MDrh+IS5ikcWkRt+qOW9duWr0AUDtXPpcEQVpU3NdDZSjFVStBL2hxQia9DuBjRQbMF8uARhN0/TeAJIyNRs2QRH/329HPbnHvKDBFmapTYjEOiGVRGUoiaYVwk7joyZ+JR4uVSfSach3KYSVENtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515567; c=relaxed/simple;
	bh=uNec6+w51dtNEBRRFtWW3+PljCIgahJliP3Dzp9Or8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ludH2PcKSjZB3r/CDVCuu2gdpUHCSCeg4w2U1iKNrRwwLsabTAz8tIoMJYlGpgekJC4ZTAgbjrngjaZguz1+9S0EAW/RDRkk09W5NU8gPfakMmWMh1JselUcFsPxGNjuEVFaWKyNeF2HZgh83o43y2CRcLsHAdZZktfLRjzIJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGZ/tOLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CF3C433F1;
	Fri, 15 Mar 2024 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515566;
	bh=uNec6+w51dtNEBRRFtWW3+PljCIgahJliP3Dzp9Or8E=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=nGZ/tOLVTJ8Ch+krP9daXzMppAIgg5KiToQ+IMWSLo22YjF3lSUmNW2QnBHODY3Q+
	 DHs8fbdTypvc80L/vuF6bxSqFIgoI8JYtdRiz7fRKuGN7D9ne4Q+5QaLqDOGI/CH6w
	 6pBoMz1SON7ATCjPvjS7INmJ5hhO4Y8ABuzVH3cryGK12cElLpyV0omNFVx+XVC3vZ
	 l/WfCMAfEWiS8q26eEvb+kxtGRoBt7Oyf3/OjeWgV6YgYE/Fnb5ysG9JSMu3Mx1ZMj
	 x3DDW52PntfyJ2ue2AZ0EaJjnBtiUeFc9zCNnBUkXD0ad+acfjYJQTZ80pml8I8+vI
	 U42pK+gZbuD0w==
Message-ID: <9883d05e-a18b-4b41-8a0d-8b0038aeceb7@kernel.org>
Date: Fri, 15 Mar 2024 09:12:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] ematch: support JSON output
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20240314002415.26518-1-stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240314002415.26518-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 6:24 PM, Stephen Hemminger wrote:
> diff --git a/tc/em_canid.c b/tc/em_canid.c
> index 228547529134..815ed8c7bce0 100644
> --- a/tc/em_canid.c
> +++ b/tc/em_canid.c
> @@ -154,24 +154,29 @@ static int canid_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
>  
>  		if (pcfltr->can_id & CAN_EFF_FLAG) {
>  			if (pcfltr->can_mask == (CAN_EFF_FLAG | CAN_EFF_MASK))
> -				fprintf(fd, "eff 0x%"PRIX32,
> -						pcfltr->can_id & CAN_EFF_MASK);
> -			else
> -				fprintf(fd, "eff 0x%"PRIX32":0x%"PRIX32,
> -						pcfltr->can_id & CAN_EFF_MASK,
> -						pcfltr->can_mask & CAN_EFF_MASK);
> +				print_0xhex(PRINT_ANY, "eff", "eff 0x%"PRIX32,
> +					    pcfltr->can_id & CAN_EFF_MASK);
> +			else {
> +				print_0xhex(PRINT_ANY, "eff", "eff 0x%"PRIX32,
> +					    pcfltr->can_id & CAN_EFF_MASK);
> +				print_0xhex(PRINT_ANY, "mask", ":0x%"PRIX32,
> +					    pcfltr->can_mask & CAN_EFF_MASK);
> +			}

if the else branch has {}, the first one should as well.

>  		} else {
> +			

unneeded extra newline

>  			if (pcfltr->can_mask == (CAN_EFF_FLAG | CAN_SFF_MASK))
> -				fprintf(fd, "sff 0x%"PRIX32,
> -						pcfltr->can_id & CAN_SFF_MASK);
> -			else
> -				fprintf(fd, "sff 0x%"PRIX32":0x%"PRIX32,
> -						pcfltr->can_id & CAN_SFF_MASK,
> -						pcfltr->can_mask & CAN_SFF_MASK);
> +				print_0xhex(PRINT_ANY, "sff", "sff 0x%"PRIX32,
> +					    pcfltr->can_id & CAN_SFF_MASK);
> +			else {
> +				print_0xhex(PRINT_ANY, "sff", "sff 0x%"PRIX32,
> +					    pcfltr->can_id & CAN_SFF_MASK);
> +				print_0xhex(PRINT_ANY, "mask", ":0x%"PRIX32,
> +					    pcfltr->can_mask & CAN_SFF_MASK);
> +			}
>  		}
>  
>  		if ((i + 1) < rules_count)
> -			fprintf(fd, " ");
> +			print_string(PRINT_FP, NULL, " ", NULL);
>  	}
>  
>  	return 0;
> diff --git a/tc/em_cmp.c b/tc/em_cmp.c
> index dfd123df1e10..9e2d14077c6c 100644
> --- a/tc/em_cmp.c
> +++ b/tc/em_cmp.c
> @@ -138,6 +138,8 @@ static int cmp_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
>  			  int data_len)
>  {
>  	struct tcf_em_cmp *cmp = data;
> +	const char *align = NULL;
> +	const char *op = NULL;
>  
>  	if (data_len < sizeof(*cmp)) {
>  		fprintf(stderr, "CMP header size mismatch\n");
> @@ -145,28 +147,36 @@ static int cmp_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
>  	}
>  
>  	if (cmp->align == TCF_EM_ALIGN_U8)
> -		fprintf(fd, "u8 ");
> +		align = "u8";
>  	else if (cmp->align == TCF_EM_ALIGN_U16)
> -		fprintf(fd, "u16 ");
> +		align = "u16";
>  	else if (cmp->align == TCF_EM_ALIGN_U32)
> -		fprintf(fd, "u32 ");
> +		align = "u32";
>  
> -	fprintf(fd, "at %d layer %d ", cmp->off, cmp->layer);
> +	print_uint(PRINT_JSON, "align", "%u ", cmp->align);
> +	if (align)
> +		print_string(PRINT_FP, NULL, "%s ", align);
> +
> +	print_uint(PRINT_ANY, "offset", "at %u ", cmp->off);
> +	print_uint(PRINT_ANY, "layer", "layer %u ", cmp->layer);
>  
>  	if (cmp->mask)
> -		fprintf(fd, "mask 0x%x ", cmp->mask);
> +		print_0xhex(PRINT_ANY, "mask", "mask 0x%x ", cmp->mask);
>  
>  	if (cmp->flags & TCF_EM_CMP_TRANS)
> -		fprintf(fd, "trans ");
> +		print_null(PRINT_ANY, "trans", "trans ", NULL);
>  
>  	if (cmp->opnd == TCF_EM_OPND_EQ)
> -		fprintf(fd, "eq ");
> +		op = "eq";
>  	else if (cmp->opnd == TCF_EM_OPND_LT)
> -		fprintf(fd, "lt ");
> +		op = "lt";
>  	else if (cmp->opnd == TCF_EM_OPND_GT)
> -		fprintf(fd, "gt ");
> +		op = "gt";
> +
> +	if (op)
> +		print_string(PRINT_ANY, "opnd", "%s ", op);

seems like a change in output which tends to break the tdc suite. Please
cc Jamal on tc patches.

>  
> -	fprintf(fd, "%d", cmp->val);
> +	print_uint(PRINT_ANY, "val", "%u", cmp->val);
>  
>  	return 0;
>  }


> @@ -436,53 +445,51 @@ static inline int print_value(FILE *fd, int type, struct rtattr *rta)
>  	}
>  
>  	switch (type) {
> -		case TCF_META_TYPE_INT:
> -			if (RTA_PAYLOAD(rta) < sizeof(__u32)) {
> -				fprintf(stderr, "meta int type value TLV " \
> -				    "size mismatch.\n");
> -				return -1;
> -			}
> -			fprintf(fd, "%d", rta_getattr_u32(rta));
> -			break;
> +	case TCF_META_TYPE_INT:
> +		if (RTA_PAYLOAD(rta) < sizeof(__u32)) {
> +			fprintf(stderr,
> +				"meta int type value TLV size mismatch.\n");
> +			return -1;
> +		}
> +		print_uint(PRINT_ANY, "value", "%u", rta_getattr_u32(rta));
> +		break;
>  
> -		case TCF_META_TYPE_VAR:
> -			print_binary(fd, RTA_DATA(rta), RTA_PAYLOAD(rta));
> -			break;
> +	case TCF_META_TYPE_VAR:
> +		print_binary(RTA_DATA(rta), RTA_PAYLOAD(rta));
> +		break;
>  	}

whitespace cleanup should be a separate patch.

in general this is a large patch. It would be better as a series

pw-bot: cr


