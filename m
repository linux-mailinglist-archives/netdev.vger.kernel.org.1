Return-Path: <netdev+bounces-262074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yzUYMoNnomlA2wQAu9opvQ
	(envelope-from <netdev+bounces-262074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:56:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5AC1C0395
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 786983044A74
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67A02EA731;
	Sat, 28 Feb 2026 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAFvFqu2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C22EA173
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772251008; cv=pass; b=f/Aj++jQpr4lOqOBYzho+e1LILhldSylYUr9dO7IkYO3Qy09L5O250JNf8ELtOzO+06adTLf06OFgIM6+l4b5rlsX/Z0V6mcI1fErvskq/zxIKH+ZMOqxXnR2v5r0JUxJaEwlaYUXkTjGnB9DqQvDdQ+Z2nCw+xwyCWJ/Io1vj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772251008; c=relaxed/simple;
	bh=UjyueWq+/sJTIa5D780Gw69o952qBtIL3cNNez3rhmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osztIEjAxmVnfGPa3sBRh8kD4+4lz3Bd+xOduHQx+LT+nAzvCLyEZtvyhx1FCr4/EyvewGZ4v85tVX35EogmJVK71G2ChT3G+nE8Y212VnZFHUDGmgOubyoOWa4VU27oos65jKMhnynzzE/5NJAkR5pZyg3Pv6PCr/xPpq22qIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mAFvFqu2; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5069b3e0c66so52511761cf.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:56:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772251006; cv=none;
        d=google.com; s=arc-20240605;
        b=LNhUWb94hsg63MqqDT+K8YTLi4PxsaZWrCYgxHZcROBOihUCzN+B413WF6M+FiOqmk
         E0J/67tQDH1ZduBxOJi1rdy7KdFGCt70sM3WF0Em1E/dwF6TZ8gG9irVSCs2bMVzzS4R
         xdqHdILr86MpSh4yvlyn9xF6qWXC7BIxnfRVizrL7OyzSLqkIcoGSYZq/5+cM4xs+b0E
         gaR1vV0plKeENRtqmQHznr/1FH7HRdQciiZqGU1OVG7p+CvlfQUR5pb9jB8V+D+9oZl+
         k2c+nAphAyozW1B+AxmikZ8EascE3W0YUmRXRCpO2RWrupYPkbB6s2wrfdJ1W5KYxrdI
         kYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sWxTBAC1D/vRfW9FLyaVhf5ibJfrAniSbX6cBTWc0uE=;
        fh=SbZzMH6213tT2O23T6/SxOp2NwWDh9Y9IFta6i12+Ds=;
        b=H/JtFzCFbUqeaTXZFMmQw03iu5mvdfXgI7gpEw1APat3fI1bptyvQxVZFtDMDLTm27
         jdmwXYF1ZxG2rgC4wC4OVi6EAkhonCzwvHPzSAT4yvDEzzsvsWXpPs1FTK5Y5rzrj8rQ
         dnLBXHbci0NgULrVBjc9pv99ienYmXKrmqKium9SI2P/2/4Icrq4Se0dKGoeLA1rfXve
         YqyA2Qeybyj+or2q3sYayCRp+fZ2O/tGvGoWpddy0BTYwjigWFIY+AfvRu7ddg5QnAlg
         8ANJBt+KlodsXKCmkslwI998gQ9fZbKrJukXP3n0och4zUGXbEZOOFHE8NA55dawNRMh
         reYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772251006; x=1772855806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWxTBAC1D/vRfW9FLyaVhf5ibJfrAniSbX6cBTWc0uE=;
        b=mAFvFqu2017CIbSopja+PoW0LP8ovJC8qj8KnQwqUlg2AIF/1WDfCRLbI1HxZx0UnE
         kapDk1ESkAGWYYy6B9sp2ZIOLdK/CWW6aTC9WjmWaOBnBZL+m6itC3viZdrcQke5Lebq
         /Dbo3w4/R23cA8VxU3ZGI6V96VaqrjaaMDNc6bmKnh0azRaT/MVRSiqaJlI88m01eGKK
         FYk+QeRO1s1mgJi/zoylPuAF8xya9Qg45HMQHS1M7zMAk0Or4ZHAZrOeCGU1FubHsAJj
         lAp3NVGTwxVOHwKggiwN6CJr/h2+3EhUnAYfV98WOJKi/U3NG83ZqhVBQrCR7wTmxEGr
         WUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772251006; x=1772855806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sWxTBAC1D/vRfW9FLyaVhf5ibJfrAniSbX6cBTWc0uE=;
        b=Ct5cVJS/3xFfMjLc9gX7EgVqXmvRMd3nHfiLwLPAtxo5T5eN28PtiXS4z4ABTJl2zJ
         qLF5+2mR1G1pd78hxjnEsU/UkLM8Q4gF1lgYFIk7PQM6OmHNDs32eWzXUavQjJQa8pfa
         al5BLgzRRVDQAI+M3VEwqeTLpVC0lIwY2wtK8TNdfa3/MI3pIH/xSTsmwhVrtf28hNue
         angLTmybuadZXKjxlzlIohOEHqDHzV6DQfJ1Yaaurda+JKgVSqKpncTGiV0okCeKdt0l
         8sa5VqkBO6ofPa1IiwTSOMoYA2/ft8COEsWNKFQDNzO1Gex1APzurIvWNayzUO3/T4Oh
         kgtg==
X-Forwarded-Encrypted: i=1; AJvYcCWhIXr5L396xLMd5tAe9fP+vXdZ6Osb8IUcyknlURqstdSeBEn2Iw2BueTNeg+OMdXfG2LI8og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68mBVooJYOxQyF0r9CevHvL2Cr2Yv6G4CdXf9tRK+Y/AE2xGt
	bqRV7f/Nb/f0LcBa8DycpbsTXqLxt0Dg0VQqCQmOB+OuFerCZehltbmY6ExwyP976eS4j/kkQ3L
	7eC+4Cg4s1oFSPtQyVLfzNZt5k50Asv3V2notfPno
X-Gm-Gg: ATEYQzwiVSt7mUSQ3i8/wZeHH6R/Kp6PzQQwITJfMCkUi7EUP+knIsq//OnIXULBjGU
	pUaNRJ3lzJSTZMLfvK2GyUZ+IjF+QwjlCl9UcCe5Dj4XCO/JerYSRDa5144n1ib4g0ieGa9wYYU
	EOQ3yXtaPz3bSq5gHfAQHWMjTKgrzguWjXGoGAa14r4ha4/jMvQ75xWa6Ys7kQEJKCZrRiQ+yfO
	5TNYBn0ui14OY5N5RL+CaFfMYWst7VwSSWMIxtPGzLjv54svGa1GZ241BAUi2B7myXaqSDOdjs3
	etI68ck=
X-Received: by 2002:a05:622a:1386:b0:506:7049:c768 with SMTP id
 d75a77b69052e-5074433fb32mr105636931cf.9.1772251005888; Fri, 27 Feb 2026
 19:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225133758.4553-1-fmancera@suse.de> <177224881128.2851960.13487790635140793923.git-patchwork-notify@kernel.org>
In-Reply-To: <177224881128.2851960.13487790635140793923.git-patchwork-notify@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 04:56:34 +0100
X-Gm-Features: AaiRm51d8esu6GJXSY1QhZMMgz0_ubB6Ue8FcsRQZ2EEKja3SdNxxx76VXDiknU
Message-ID: <CANn89iJo0KEMG_GeN-GDeo6nOX_C4G0mypKMgMagQ3dHjsMKHg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipv6: discard fragment queue earlier if there
 is malformed datagram
To: patchwork-bot+netdevbpf@kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org, horms@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org, dsahern@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262074-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E5AC1C0395
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 4:20=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Wed, 25 Feb 2026 14:37:58 +0100 you wrote:
> > Currently the kernel IPv6 implementation is not dicarding the fragment
> > queue upon receiving a IPv6 fragment that is not 8 bytes aligned. It
> > relies on queue expiration to free the queue.
> >
> > While RFC 8200 section 4.5 does not explicitly mention that the rest of
> > fragments must be discarded, it does not make sense to keep them. The
> > parameter problem message is sent regardless that. In addition, if the
> > sender is able to re-compose the datagram so it is 8 bytes aligned it
> > would qualify as a new whole datagram not fitting into the same fragmen=
t
> > queue.
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next,v2] ipv6: discard fragment queue earlier if there is malfor=
med datagram
>     https://git.kernel.org/netdev/net-next/c/9ff2d2a98370
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

I somehow missed the V2

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

