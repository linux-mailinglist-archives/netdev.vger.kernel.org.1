Return-Path: <netdev+bounces-264644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBDDFCVJqmlkOgEAu9opvQ
	(envelope-from <netdev+bounces-264644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:25:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C3A21B103
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5408B3024EF1
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4D336AB59;
	Fri,  6 Mar 2026 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy7vsIbk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796E36997B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767522; cv=pass; b=VTPPTbhOkgaJVd5bHBhcaul/wPwdisItqCcaColhkyYCZTfIiBrRQaZIq5wcpAGIzPm4xc87AAgdD+hK1y3ra+fMdwQ7ecor3+y9wNKwBRi5XMc6MQh1sn6Wt9xyhpfW70qQ+evQtRvB+JUJuu56YDwQF5BE2CCEX5eOWNdjLgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767522; c=relaxed/simple;
	bh=/wPo3N+CrvUnJfB4H3RSuOrFnU1vMIbA87H5pK9yMr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4nJ3L4mqpsmwWnvhCVGnMVgmPYEFIuirBLPBMn2pyw+xztSCJlNoxiCKpVKnZYjTJDGPzraTPy5UTOo34rPAmPSNa1CQHWY/XclK78IRaoGHtvUv+znkRy6bq2Ff7i2j6AUqFaRMS3xQO49X0ZyhnoOeu5OPUBzkcVvTyibOis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy7vsIbk; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b936bedcee1so112815066b.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 19:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772767519; cv=none;
        d=google.com; s=arc-20240605;
        b=aVSTll+yI0J7NI7zWbcPmcOORnxAJhXGXtz4mQfvNJDXuOMX8rjyuU2g7Oq+pexfie
         2Yc2fpMc7fGffQVheUnpqaOCUctVS8Dxlb6OU2nzWnapdFYmgifVsoL39BSBB6CTJGWd
         dfQi4p6dXo4w8X0hScuGI+W1o9l9F02EumeOxX6wuO9A35N+pRD0WGvLFp4Xw6TS59TS
         dkTDb7xszVVstNu3puQiLpmuoYQuEieKej326pEafIipGpLl/gJ3eJ/We9bmnX+wyB5A
         RCIy6H0fiExoFXNtVRUE5S3k7pvIS9eJjv6KTKyUYVT2k6nRzYNG4NqJ6DMEYlTHy6wT
         oMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/wPo3N+CrvUnJfB4H3RSuOrFnU1vMIbA87H5pK9yMr4=;
        fh=HhvC+4UWc6MVVdnbUeldnKqP21F7Vz83TAnzkmhomyU=;
        b=cKxxbu2L7e0/6kv+8rzmrKIsSrSO+81cG4alFmYq3I3uwrLeMdBCdfjLcaaOMlsUlJ
         cBaVlIKgG4pEyeUxXkx1RzLLHNkgWzy4xhXIdq4WqAsqrX2pYuKrmZkUjOZc+CXWlerV
         qCkRFtRmac5Sp6Ur/IKOLmp4Sn7jr+2nhWKwl2hK5VBHBCEH1s7NkyEQVYIM+Kp442Fe
         Alw42UnozI+wmiIvuTzinwkx2v4IQFC5IZhQRXpIW9Je2226dzQ54WOx9GL2BVzXtjCN
         usGopGqwOTzRP/13dmGI+SLYv+eEonxD9GkyImZpSqVwOnryb/p7CHtl/47UEC6qEes8
         cjOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772767519; x=1773372319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wPo3N+CrvUnJfB4H3RSuOrFnU1vMIbA87H5pK9yMr4=;
        b=Vy7vsIbkxvGWMOvWiuGJD2rKeneV01WxLlorT0uxwkiKk2c/Ez893X0+m+vRijvmPv
         1BkWQImq5/oGLX04lrPomZ2j+Gmy8UiPRQzNbamVwJTaofQFI0/j34sPGRQGv1Kj7G6E
         7cFoZXF585Vhvan+J1H5g8fSSFhfaZfXUgxzeECdbJyfp5effQjx3q8gVF6IqY2Yw7Et
         Wav3GhznV/aJHS3ZLBzJUSE3Tqp9iGEMwYgVSDaoEzgdqRxUuL6Oi94s9SsBTgyGAW4Q
         MWATmhygtMgXNmYixZTOU+I74KFw6tC1WfGghN+SvK8ycaE+vEKcOvvE316frCIpUm5J
         TJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772767519; x=1773372319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wPo3N+CrvUnJfB4H3RSuOrFnU1vMIbA87H5pK9yMr4=;
        b=grr9Ync77gkCJRpXTEZaQPa1G/2zr1E76r4qAzbt6+G+Y14zuxIXNyVzSof19Rvzn7
         c+wkuDTf7Z/TuAQ3JBIdj5wMako1iQi0+fNAxa0AXzXsR5s3Ma0G9WKu2xQdAn7gFgDY
         3rJO1iwn5QjHpRSdAYSRXk1bflahh5I8gZExxgqPTWdydSeFu5hOVa/TMFPx6AKvoZBq
         HkOkBnK17Pb3dkE5SMPn7+k42PuMh3pz+J5ThChgOjhaVcxgw7JOFAEbA20QlcoaTgQG
         CzvSrOVdtODcr0ssEoNOs+98lBif5GvZk/PCEljWQ8dhHh+vApwSvPA++xQT7+Jp5XI2
         uuRg==
X-Forwarded-Encrypted: i=1; AJvYcCVh7r2VEPNlC7D4TGC4DqqvGQOb75pAdRgFo1jtWbfVnI2lp01SSVjfPDNNmWVf4eYMgUlQnSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwbblakUKrlR8v+xA/YIlOOJAZtATv5u1+Hi4HBjj4UpiO/u1
	T3VQ6VGD+bW7mjOuVV0Wc4vcucFAUCQCddQAV7RjxDO4ih5Hsm0ekrl9LrkED6kTuCc4tTqRC1d
	prsWg25Ur+ABMGflWA/ETwgcXGwNDPk0=
X-Gm-Gg: ATEYQzxjGWQFRqt9CetUJBiADz/MHlv0mi+CXpDRMzrB3De1VLTLsUIbsQtTq0N0pd/
	Rm05mOgnarEZeU2da+hbRvsSB5MKSjcFRNYRgY5DpAE/KDOe3d13kdJM+8izGl/PsxRDz2Ms5kU
	E2ukl0VziBzFgSSRI5pWpdhnIxo6z03ptHPP70EZKj8oH6AgnhxU95iWACKznQAWbOnVJwbZYU3
	DiULCZacteiEfJf3+GIk4WY0VfLAKSdY1H8snDS1XtiPCCzvVWDjiTKXuBOHf+/KXXOlGP7ipux
	l6dPQT8=
X-Received: by 2002:a17:906:4792:b0:b93:86c0:d8c with SMTP id
 a640c23a62f3a-b942e013780mr13266266b.8.1772767519292; Thu, 05 Mar 2026
 19:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302174056.796540-1-dg573847474@gmail.com> <d4307af1968ae729f4b937f88606c50d9a3d521c.camel@ozlabs.org>
In-Reply-To: <d4307af1968ae729f4b937f88606c50d9a3d521c.camel@ozlabs.org>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Fri, 6 Mar 2026 11:25:08 +0800
X-Gm-Features: AaiRm50_XjfPuSCHck5pyfZpF2CNLh5iN_ywG9vrITwA05tBQED7cJLdsNo6UjU
Message-ID: <CAAo+4rXxmiz9fOMxhVr5zEd5Hq+pjL2pht10JN_fmoZap6=FSw@mail.gmail.com>
Subject: Re: [PATCH] mctp: route: hold key->lock in mctp_flow_prepare_output()
To: Jeremy Kerr <jk@ozlabs.org>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E5C3A21B103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264644-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dg573847474@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lkml.org:url]
X-Rspamd-Action: no action

Hi Jeremy,

> For v2 (as requested by Jakub), can you correct my email address? I'm
> jk@, not jeremy@.

Sorry indeed for this mistake, I corrected the email address for the
new patches.

> You could shift the mctp_dev_set_key() to an else block here, and avoid
> the goto. Following that, it may be more readable if you invert the
> logic (if (!key->dev) ...), but I will leave that as your call.

No problem. I missed this message while making the v2 patch, so the
change is addressed in v3 (https://lkml.org/lkml/2026/3/6/201).

Best,
Chengfeng

