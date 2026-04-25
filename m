Return-Path: <netdev+bounces-281126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG/qLPYh7WnFfwAAu9opvQ
	(envelope-from <netdev+bounces-281126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 22:20:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B456467A02
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 22:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73EA13009B15
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 20:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75630B533;
	Sat, 25 Apr 2026 20:20:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A038155C82
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777148402; cv=none; b=lKzcC+dVnWuP3CvqJttdSOcKLJc4+yEEB5QpvhmYFItS8kLl0YgM+c1xDxvMHFxL9TxxwjppIfDj7tStms6SJ+npHFjNB7WzhArLbMyhG8Hr75y/RHxQWMmHxDIcFRHu9f7QNxGJxYfDjQieM1oPZXUPgoKDtD3fNBD7Y8VkVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777148402; c=relaxed/simple;
	bh=r3oKUJOn/iY7WGFD6+RxF8upBEJGQecaixzCKwmyNoA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PspPWSHyh9ZSi9OlSBcWfi4afdJ5sHppT/+0v4UqCK8X5JnyFFj2aHeuR5r+jgxX/Jidvh4qCW3I4JdLZ1lBuVPgJBYqqM8ZKsGCgPHkCYJFXh/KI6cVoLP/29tKXP4ZcpEteZaZI4BvML/rpI4jG+XveggetBN9jUNRn2xEpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43fe608cb92so6062761f8f.2
        for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 13:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777148398; x=1777753198;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAFuJtSKoTyiw/XRZANxtlK9dfJ7AerpVvhrCljQA+A=;
        b=SSs/t6mi7bDVsSbI1dMdEQxLDZxCKXC0kIGVx3kCvK+j0oXflCKNvz6qN7G/6Lcs1S
         L9509gILpQprvaqFuZt6bITso5CQkkHBjEHNMi9iaraL8WV1O16JzsPHQy1k8ics4sIk
         Fj78dbGrJzkPSNQfs2xNttO32mP4nsviUg/lMyzwfd48TUhD2zxQP6DYtIoIRb54wyIj
         QYQX6bclhHGjUiqz6e4l5PJABW7OnCwRLaCpNE/lLi3bwuPOiR6joFQJCAND+12pqafm
         ksE5Z/BhjRUm/IdXb8Av6yAGflH3JmfMIM8lXWaIOS9VLh01u8bwGhGFF1dLOweexJwX
         wXZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8M+C5SsSmyo1Y8xkYFDwzZUdwjJhb7Vm6Uh6eVkfcfOoR7dix1lxcQN7WUZwdUmaPjZocZ1Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Hn4mJjyfvpB4B51UmuvKbkowCDHJBP8mMzxfWQtm5+PHyNGl
	2nWpiXBBW2fRc+0PfOCj11J4YEqTFHRoFSY8IHQviv2DYrkR1jCAo2QQ
X-Gm-Gg: AeBDietVOJaZERaxP+wI1vm7VXdzKqw5HFwK6FLv3XDRkEWWkDTIlKMXLNYVMhHyotL
	awxycC6cTbNtFwFokjNf9pPwLzLh+tHU+ed2DZPiGm55KZtIv/Ex+/bYueabJ7ANqczaWN8kd3I
	HmnonS6fa6snccKQxo+VdUrf0TtHc3TLWsgAekum35vL28+zureEEXmbfa4jTNQhULo2pE2ENUL
	MVmwyO3+RJ6Lpm1A584bDIGTsra0eAIvY4TO48FqkwIikV5vOwtpG6OCWFXEdFBPEqd8HvwKdWj
	vpbA5YeXedXy5Inpoja1opsIUin7oKAXsJSDRmXpcsmtpISE8T+n10EyaOfE0Fj0BTt1Xgc8apS
	GceruCXMOY4oCXgQfzlhTb/4L2l6mez5KaH2QggmQtAUGbDVXoGEMM81ugNxxLY9K1Z61oKx/F8
	3KSCyKt1ZKvhYT5ruWj4dpYMt4nS4B09vJuygeYe+v1dfIcpTDsQdb5xLojCmuGiPVKoI19dfdF
	YSx
X-Received: by 2002:a05:6000:18a8:b0:43f:dd91:b022 with SMTP id ffacd0b85a97d-43fe3e0a2a9mr57375947f8f.35.1777148398068;
        Sat, 25 Apr 2026 13:19:58 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a071sm32495435f8f.21.2026.04.25.13.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 13:19:57 -0700 (PDT)
Message-ID: <9c1f6c24-3641-4bef-aad7-8f276def50a8@ovn.org>
Date: Sat, 25 Apr 2026 22:19:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jbenc@redhat.com, e@erig.me,
 yi.y.yang@intel.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, ldy3087146292@gmail.com
Subject: Re: [PATCH net 1/1] openvswitch: reject oversized NSH MD2 metadata in
 push_nsh
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, dev@openvswitch.org
References: <cover.1776929256.git.ldy3087146292@gmail.com>
 <9d2b5c6127e149ebd35094d662bfd008c20347c2.1777120226.git.ldy3087146292@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <9d2b5c6127e149ebd35094d662bfd008c20347c2.1777120226.git.ldy3087146292@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7B456467A02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,redhat.com,davemloft.net,google.com,kernel.org,erig.me,intel.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-281126-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovn.org:mid,lzu.edu.cn:email]

On 4/25/26 6:40 PM, Ren Wei wrote:
> From: Douya Le <ldy3087146292@gmail.com>
> 
> The NSH header length is encoded in 4-byte words in a 6-bit field.
> The current push_nsh validation only checks the MD2 payload against
> NSH_CTX_HDRS_MAX_LEN, which still allows metadata sizes that cannot be
> represented once the base header is included.
> 
> Reject MD2 metadata lengths whose total NSH header size cannot be
> encoded exactly in the NSH length field, whether because the field
> would wrap or because the length is not a multiple of 4 bytes.
> 
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Douya Le <ldy3087146292@gmail.com>
> Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/openvswitch/flow_netlink.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> index 13052408a132..8a1ae5309c2c 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -1432,7 +1432,13 @@ static int nsh_key_put_from_nlattr(const struct nlattr *attr,
>  
>  			has_md2 = true;
>  			mdlen = nla_len(a);
> -			if (mdlen > NSH_CTX_HDRS_MAX_LEN || mdlen <= 0) {
> +			/* The NSH length field stores the total header size
> +			 * in 4-byte words in 6 bits. Reject MD2 metadata
> +			 * lengths that cannot be encoded exactly or would
> +			 * make the length field wrap.
> +			 */
> +			if (mdlen <= 0 || !IS_ALIGNED(mdlen, 4) ||
> +			    NSH_BASE_HDR_LEN + mdlen > (NSH_LEN_MASK << 2)) {
>  				OVS_NLERR(
>  				    log,
>  				    "Invalid MD length %d for MD type %d",

I don't think the check is a problem here, the problem is that the constants
are not correct.  We actually had them fixed in userspace, but looks like
no-one ported the change to the kernel side:
  https://patchwork.ozlabs.org/project/openvswitch/patch/1540503710-23597-1-git-send-email-pkusunyifeng@gmail.com/

Adjusting the macros should solve the potential overflow issue.  However,
even if the value overflows the 6-bit length, it will just be truncated to
a smaller value and nothing bad should happen in this case, as far as header
push is concerned.  The context was wrong already, so pushing a truncated
context doesn't make it more wrong.  But we should still fix the constants,
so the checks make sense, of course.

The same for alignment, if the user provides an invalid header that is not
multiple of 4, the code will just truncate it to the previous multiple of 4,
which should not be a problem, as it wasn't correct in the first place.  We
could add this check just to warn the user that they are doing something wrong,
but not having it should not cause any real issues.

Note, the userpace change linked above did fix the real issue in userspace,
but for the kernel side there seem to be no real memory related issues caused
by the wrong constants.

Best regards, Ilya Maximets.

