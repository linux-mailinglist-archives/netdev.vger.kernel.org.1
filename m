Return-Path: <netdev+bounces-303920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Iry8IprSRWogFwsAu9opvQ
	(envelope-from <netdev+bounces-303920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:53:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C386F31F2
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:53:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="DFhL0/w5";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303920-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303920-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88A243004405
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 02:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C435E30C60F;
	Thu,  2 Jul 2026 02:53:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9C2D8795
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 02:53:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960788; cv=pass; b=JMTBkEqHp8JrcuiLjxvkDtHaUVQYY6o/VDj6Y6npw9eVuo+Np3eF3EMRge3KqoLFi3AAJbPmWTCfbrnsPN2w+Vddh9yUNYikpk0Ria5wW2JkwH9E3Zbt6FuwGaxsB1pmdRWgMk1Z7zmHA4kbKSffi1pZPJDJJmMPMiB490tj1oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960788; c=relaxed/simple;
	bh=RHkS5EpOZOhrSnmETjxo1q0rOFFuIDhs4Zju7RuGz6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYAqAYwppLeTmxNjMl1o7UjWTaCLUbLr5Bs8bkWA/6XhdOYJVfqG7YpuJj9e7KYsL1aBmpGty/4CWmGiPZ5wqh9yanCsEoXwHje260HZBQiMLTeAHmGtbrlBtnAlv7fnZx/6XYY3tv2XxlVVzw8MrA3vxAurDSXVRXmfama7hGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFhL0/w5; arc=pass smtp.client-ip=209.85.215.170
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso472543a12.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 19:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782960787; cv=none;
        d=google.com; s=arc-20260327;
        b=KYzJB2wv33z10xhGdP6UD0Vgt6FoG4zjRlPmYX4nRQX40RBbVTMhe3SBoIbi1v6WjP
         qZxHAkxKoTiAP+Wj3Us7LBszV35RwfXYkj1R/GMZBlX0HyunxUfgm/u6uYzp3GowQQYG
         HQLu6HDo5C3Lizxkzd0G4/bVN18KzcnCEhOTQyWqOkAooMGHwspF2qHQaohjIwWF93Bp
         iX1rFj/0GBj9jXOAyUFZYyo77OnOXCEStfJ/bzK0KTBewC7ThANsKbcCmMxf+0mv7Vt1
         JdB8R/8eMnzLqW1mavPt0QETXEOtq/HKtNVj/VAmjiDqMb56s/q21PQ1uF2M1jsJXrDe
         PvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RHkS5EpOZOhrSnmETjxo1q0rOFFuIDhs4Zju7RuGz6g=;
        fh=2Axi9lGdaP/PLO0wXPZ+7iTdRqnjgnMgiuIDGXWbgM0=;
        b=czX1V0oDCpUynQXZzQiL5OS73/FZKlPjgeKc4F0UwFCalX3Ip6D9KoNOBS2KFvkI82
         XaKmP1/4U/qb0YFFvgojM5M7E381CQipDiWCLslJloqGFjrv/qFlEZkdnQ0UYZOiG4hp
         1KfHLKCA4lGaKaXchhGJTsO2/5HLzHWTVqxFUCrewMjzz6yOi8Pbo1K35fSGxUU5o/3m
         Ss3t/UzYd3QbmF4uUNFsmwmjSsSgbDlt5sdXb/b6LErAcdG1eBmf5WYeExl2SiI7MH40
         zRUWj3k/9JyKWRYCzmQyoAgsPUOXzKwD+YriQ8ulS1kqVYkW4VlB7iSw91NcO3iwwaP3
         Bogg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782960787; x=1783565587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHkS5EpOZOhrSnmETjxo1q0rOFFuIDhs4Zju7RuGz6g=;
        b=DFhL0/w5FOiH7qMFpVAcCTycR+R78kOWZhGRs77Fmv/9F/Vbl0qwYCy4+mRu6a8d6N
         QVT8nnQLECMcmNnffBIUjwUUWfyJmOFNCiPbhJRyzFyJbDPUNVEUgBa9dcA10oXjagXj
         xvgxQlUxu/xFkrY0vtagIW+PqVFXq6cZYCQ0iv0ugS19aCttVzXj6Lv74Pah9r/rC5yp
         EB8ySUZ3GKcFlyhGPTQA9TP7Ir6aXJ59z7pCUCYNh/FKvSyXQP2iY4AlxSbbvEpRcWR6
         QjvEh5Q3IB+kNud/vT0vgLg0FMAp9kLlo2bEZzmM+ZOdYTxOW6xLTKFX+heTpRJVIYsT
         +i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960787; x=1783565587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHkS5EpOZOhrSnmETjxo1q0rOFFuIDhs4Zju7RuGz6g=;
        b=HsRjM5fzXlyIDh8/K0tJzbyS4l5RDgfafl7NoL0e38mlHIrf4WVSxe2snTKm+tRbVp
         5uZhmAaifgm2HAwpAkzMpkLJrxJiyjDeYIr0X9qLtgGpwqS9JxfO0pbgNd/JJkm71/Bs
         S3tI41PiGPNX5JlQS5SF6nNLM/DfkwIJG8OQGdSGbLT7c4r/bhesnJrSvRzXtqc9mea6
         YcxlN+lXCJ8WFbeWlQrG6xMdzZLqzca0NxaxIkcCTu1LAxfsQO6DXYfBZLqAEPvjhN8E
         O2mPAyNhEYcB2q71IFQUu6nSUmjfOBiWHQPoqp5c91XfcompkQakBjvcnm1YAFZkMkaR
         70HA==
X-Forwarded-Encrypted: i=1; AFNElJ/G1AeN5mbEwzVS5ZIYRQIV7WsnYJ1p5A7Xef3aYTlLWtv04rVPrxKHPNjAOhw1vMXr6EEvVFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaH3ktU4bxPojOhrlcwdvQUSRBBO0p3dT/INf3I4zaXbpLhXi8
	ju/ArR5Zfp3R5oLBaqitAOvVEzA/zBEva96HisH4MPtH6CBWCX/ZdGkPBdQrddR5DxKLkpAYHy/
	acGypofbvomfEXKuHYv4jTtfFyBfY2kUXU6aoviAN
X-Gm-Gg: AfdE7cmZHlYHbnBrqnOI5q80fUn1Ya/v/85GJpDntP9qwFpS4tM3ibVBwJrCaD1I9KO
	nnzRyg6li0PXtPPY+8AMXaxNVB0xvnqNWB0lOqavsYY3sMMyIUxWbwWy8K4ktzAz6fHqoZoLWJ/
	ak+xnl7BQUAwOU6tzLkMd17H5YDW3aPIVTmFqmLvkgLgUpYGEdIjrHu2FdDNOL1jJG0Zhlk/+Kn
	1Fhf8Wo3iD6+whpg3ZxlOiN9ro/hU4rSJzmZKqOWkQZJ+DDiQFWJEUxFBaqUdZveSJO9a7VYy6K
	zbhPTUZnd8b24iBXqCaSdIJwjza6FnaoBPmPHPnWVzfroFP9nX5mc84u7nGVJUkr2RghQIKxbw8
	Gzka+h2Il4Vc4fuyyTB/BdmkfJE/tH9Z5iU86BhlquQ==
X-Received: by 2002:a05:6a21:116:b0:3bf:b4ed:5579 with SMTP id
 adf61e73a8af0-3bfed571ba3mr5054648637.59.1782960785904; Wed, 01 Jul 2026
 19:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701125016.3650708-1-edumazet@google.com>
In-Reply-To: <20260701125016.3650708-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 19:52:53 -0700
X-Gm-Features: AVVi8Ce-zIQ9jrBglN4i5JqfdQ7i-yM-2prAfiPnWJRdGdsKWR-uvrRYUW9M6rA
Message-ID: <CAAVpQUATbkdLMY=qLgmvpYFVtVfB+YcRWO1oX0Wkm6Kg-em19A@mail.gmail.com>
Subject: Re: [PATCH net-next] amt: no longer rely on RTNL in amt_fill_info()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303920-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62C386F31F2

On Wed, Jul 1, 2026 at 5:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Update amt_fill_info() to run under RCU read lock instead of RTNL.
>
> The AMT device configuration fields (mode, relay_port, gw_port, local_ip,
> discovery_ip, max_tunnels) and stream_dev pointer are initialized during
> device creation (amt_newlink) and are immutable. Accessing them locklessl=
y
> is safe. The stream_dev net_device structure is protected from being free=
d
> by RCU.
>
> The only field that can change concurrently is amt->remote_ip, which is
> updated in the packet receive path (amt_advertisement_handler) and
> workqueue (amt_req_work). Add READ_ONCE()/WRITE_ONCE() annotations
> around amt->remote_ip to prevent data races.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

