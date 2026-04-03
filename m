Return-Path: <netdev+bounces-275105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPSfNLvaz2mb1AYAu9opvQ
	(envelope-from <netdev+bounces-275105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:20:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D73395B8C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 444AA303DAFD
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5010392802;
	Fri,  3 Apr 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/fTovq8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676143612EF
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229553; cv=pass; b=JmyvDkO00zbj/+C1JVCGd7wSkFYpUDUdrC/lMfRPl4w/z4H3yxSXW2kEz85I8th2pkVabLdRrAwEOwSDJDqm0XE22hjfJaWjWzDUlBFZ6rwil5BpfZyLd+d2YUsa4dWl23dhNmUTUu3WEgeTxH0g8GK3xHE1DwXiK7KUIYnOsew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229553; c=relaxed/simple;
	bh=B9ChwxIqjVPjxIdXdydUQ28VrQVd0/3Zr/7xPOZkTm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDn4liOksuyvejGVA21+7zJZyWhoXHsnsdD6YDSvaoPAY2UUvPaEsfuK9OPvW2UJdM+qsY+q+mjvQIJZssXUi/ZPB8mhRwq/4fHcFozcxoJKHaRFu4cLzXTRY2deGfsIpNwLM7QHjoMS4SocJqO0cJoFTjF0aUSZY4yGjUoAdGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/fTovq8; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6830f4f34c9so148596eaf.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 08:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775229551; cv=none;
        d=google.com; s=arc-20240605;
        b=DbyhalfxdfxQjxNcin3BRE3lheVPEZFqfgQFOzCaJsdItO6LAEZPH0EQl+2dI1YUkj
         RAnVaB7m+7ENfoAONnHfY8RACY2H1F0TB1furrtLBIbOlbDM0yQpaH9b/Ck7K41qEg2S
         Q7QKEOLCVHKK9IOw8H/LFIOLXaarQmzbC0EWO4XW+/HjHbThMNP2Vbp1t8dxOYra0r0z
         LDAJkJch0qaCCa5Do68bhGzT3x0bQfNjA3Js/RMG/uw8k0yWWfTsMFt8gH3DwZcbVnPo
         3NsMGJnT/XekmPi3OzmkVqvm9BsZIIkSt1DdrmsfhIdepy1pHRnQm5RLccOWASzigS+c
         OlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yj0csSExbiRXKyxIzdW4Y1VT9MMdIju9zbDZii7ejEg=;
        fh=1ffhz1LCn+XjckKwJV4d58j3PNJFvGXtZYChy/J7jCo=;
        b=k0d+wOJrgJ7PwBfELV5d3v7NEXAc06bGrCTqpUfVhRu9EyvUe6xwBaYHqa1Y/Ee3PT
         87JK6vIXKa6mfAEBKV2IM8/HDY7MdT8u6ElGmHc89n6AKHCixuDBBFNP6zzZxdz8vMvI
         puUfLIHz3Wc9TnUPFj1FtaqL9L+qbThdMWTm7eUef8YTh7EEL1xLcFVFBi0fvdscUd3K
         EqGO+UqbSecl3K6oE5m0xmK8oQOnt+m5rqQ2geyEk4copChVfpOe8E4b6xgDHapBlk5J
         5hwvJKg3Vn4HEaQA+iJmXaOOLXKeJLxN/N4Z1Wus7dGNeflAR2Z6GdE5jl7pJjp/AFSq
         gMTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775229551; x=1775834351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj0csSExbiRXKyxIzdW4Y1VT9MMdIju9zbDZii7ejEg=;
        b=S/fTovq85BpNtXU19bsRHxf5dJWNxncuXbmkqE9ouurDtGI46+98rIsmInqyl+yvdo
         O1STrRb0iaduJKx/eDpv1uOUlYJ2oMYuBIHE16ZkoRzSyfCxDNhxoOAzicXBamKG4oIe
         EIVAwzWcKc9ClOfz3QkrycNmOUuZANh53XE9lhk3hgPBJwJdPfuLw/+YNDBEqtGqHJu6
         MnLSp21z8aIKk79yzSYLj/mQn779J8P06vUKGsLHUxFRqdsBTx6ndHiJNasSruQkW6YF
         oqfGk4PdfM8/TTFhO1dzJEDlPUOZD520t0gtdU5D8c86VM0R5dmHwYEON+WI2YNuws7v
         7rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229551; x=1775834351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yj0csSExbiRXKyxIzdW4Y1VT9MMdIju9zbDZii7ejEg=;
        b=IGFLYvm26m+eVaM5Q46IlBcZFcwcL8ITIRq20d6FnesRukJdBvDIwZ9iipfbxy3aq+
         97/R0C6tXsQuhLwVp9Zsa0xlei4RrZLoVjBgr9SWmWgQ0Jsib3k8pHPIisc579uwVlyk
         BFrNJEfE8ZUP8BbxsU0ya88rJb1oI4/yxzLb8AtcKCQsm/JaKRUHpn8PWp5lCGQPAGiq
         n83NB6Xs5SyBCdLSvI7hlVNlrEVm4ONlPTBvLdwVKEmCo0GJxwgpDVfw7m64RqOwaOUg
         Ct3XMuK3P9q99S23Mc0s4pZXvSQcu043/DI2TRa0iB8dxB6QvOWsx0ZceBH6seIXzJpf
         SF9w==
X-Gm-Message-State: AOJu0YxcmJwKkSVw778xgfjSnjvKYQW4lZ5A8W8EpIxUiDtIL/ngZS7E
	FU0tCApXEJjRILPmx/i1+085CoFTTHn7NY44jy1UPqDMoJjalWuwJmNBb3cUFS7NQ3B/4znLaZN
	483ggNv9mVAvElnGvcZpG+CTiFh2+Vmo=
X-Gm-Gg: ATEYQzzc6zFnv7h4uxz/dyEbxMADk3AxzDL3/D85adwDhJLi1de7dshfeALKACrS1QB
	mtDkYNfxjshc47P4aHiC7ZyqEiUFxDw6aGKIK9YGzX/260zZbVfcymrWP5hiR4jRYPfi0UH2IxG
	/cC4J3BJkPhCG7JgOOvahJW2F72r3nS94Evxm1EOUVxZ8wwbSWV1sXrfc1E0SQQYgievINa+1YH
	5tJ0HDQQtwxXpLcCZU8WNhl9paGMWyAVCLrN/8YNHmKpVfofAczotWMcvHySU3dUk7KTh3SksfS
	UwgF4ATrKotHUNw/z9jfch7VVXE6zfLS7HppxL/dGwW5ExbLed+Q
X-Received: by 2002:a05:6820:81e:b0:682:b064:ecf3 with SMTP id
 006d021491bc7-682b064ef39mr887157eaf.3.1775229550943; Fri, 03 Apr 2026
 08:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402223437.109097-1-mmyangfl@gmail.com> <20260402223437.109097-4-mmyangfl@gmail.com>
 <654b51cd-fc06-4dd2-9a6e-421d7333f905@lunn.ch> <CAAXyoMP=o7P0-o6HOKi8dho8iLLV4LJT=YHae5Gj13xJ2ph4og@mail.gmail.com>
 <308c4474-3da3-41bf-af29-3a400232e029@lunn.ch>
In-Reply-To: <308c4474-3da3-41bf-af29-3a400232e029@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 3 Apr 2026 23:18:34 +0800
X-Gm-Features: AQROBzCLKbnn8kS3OOOL_Rx_k7SSRVBrWqQYiEeYoD1N5JQWo7VPP_aHfJR6fNY
Message-ID: <CAAXyoMOJ=RDzV2pGGN0yW2Q5hpM9L212J=QMsUw3MsiFcvXFxw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] net: dsa: yt921x: Add port police support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275105-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 23D73395B8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 10:19=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Does it unnecessarily depend on __int128? Otherwise it's good.
>
> Ah, it seems to be a 64 bit architecture only thing.
>
> Shame, because it would make this code easier to understand.
>
> For these u96 values, the masks i looked at would fit into a u64.  Are
> there any fields which cross from bits < 64 to > 64? Could you
> represent it as a u64+u32?
>
>           Andrew

EBS crosses word #0 and #1 and CBS crosses word #1 and #2, and I
didn't find any boundary patterns among other u96 registers.

But maybe I could drop those multi-word register helpers and use
manual updates, since I have to use unaligned modifications anyway.

