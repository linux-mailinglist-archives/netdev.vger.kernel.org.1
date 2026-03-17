Return-Path: <netdev+bounces-268555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGEKA/AyuWnsuQEAu9opvQ
	(envelope-from <netdev+bounces-268555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:54:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 902222A851A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D107304F4B4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D93932CD;
	Tue, 17 Mar 2026 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJalPmVu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375437A484
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744849; cv=none; b=pNdNQ3bO8OB/XEEUMxYDfoZpy7sqkRodXuQDRkaBuOEfwwMlrN+EJL0fRmxcQpeegSR6uGUYv2Wx+dJRGt1S+G5D6SRY4w2pYymSnoVZfkP23egeBNyiMxOsRr688JNs7BnKsn6BcCl0XTFfeiPkDs5ls88n9VagS5wXd27xUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744849; c=relaxed/simple;
	bh=P9BFaqiVAHISRH1/Ftr1F7bJPDlJE0OkKEIBF/sU00Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaLyJf47jqgmWLKaAlE6kxiWmOiLngClVU6ubG0nYSa+V9jTRI4EAbPOvpsENoeEAvqZkwl4UZAJ5inRjzc1erd9NmwlFuwPfA6l5TG4p5Rb1joAk3VVLPzGjtqHD7rm6ME2QOZEaBFFoTSjQ2fv/ypSOrOhNVKS2X0ixpsrM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJalPmVu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso14511115e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773744846; x=1774349646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWnPu/gx7qeFux1v3KRj7Gsdw359R9/cx6A/cAlvbPE=;
        b=gJalPmVutSjdHwj+Btg6YFlJEHlIADkXdOmfpLHmymz+Z6tHy89P68IdUlqI6fEj6h
         CW8U0EIOxDRG/pjK/zVZ4/0WfpLy4oNeIscaZ2YisLAdKdlUaUbWIugp8OCaIvZR8UfC
         lrW+bR4BXHYsBSe2v3TEY7E52Cd3DygRFbqdzorqCwVbCD4U4UJHc9/+9hG7G6t43xFx
         PPypNNdnXbmr3YdJraXXfg1HFQasIyi4/WmJx3r2AUnjrK/XkC9D77R+8zK1igTA1fZb
         I4KlSCso3tb3unUdf0tJvFeW+8pfKCmYnXJfZHhS53ZB0m9Z/wmXYlEcAyiWluWLUZGf
         PFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773744846; x=1774349646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWnPu/gx7qeFux1v3KRj7Gsdw359R9/cx6A/cAlvbPE=;
        b=PAs6t6t4wjCdlgbi2Zj4cmg5quaYpnP4L0dS06shZf6EitaNaU232pQVMVfchktkeT
         eqhGmTI9H0uMkANswhjkZabimtuX9v6V2A5sP3waQOxilfJATbfQRwea+ZiWmGJTSW3M
         Q5Sp5J8+PNF9qOtFCrjZgpqFv2a/kyqlm4hZNP9MNf6JcfBuFOq/X3WK5+P9x+GCuWPx
         SR5yh/UKbHMocGbkeeAJgvlcqSP7CUXsyoSVWp2AEscBfbYPJ9xIE1Qul8nFMGUOIVEp
         L27cuqVCVxViZJkOt1mJAd8LpX2ZS0BhS7keunOHwknEa7/TFRncmRJ+2VUPs4eRDDju
         VdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlcSf2yuzWmrk0jkUL8XXcB6v+1C0mCGyZFcsJesNTKqoCZrLKTmBmCDzqKf5eWyGLnhoIlQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyqtuPhcwuIUZX52wKw5Ho/08KcAKiWoAcylQ7WJzTSz4942p
	7Et5Zt6bLv2Iv193cSuy7VM1oA26SaMrmiTCifItmFY8fc+P0f0OXnjP
X-Gm-Gg: ATEYQzyY8z6Lc0/Ts45YnyooTB1VKCnRyEEaYoEoqgP0bIlRp83Gm4WGWpmB+gJ1ggf
	GdUdmH629B19QWYqKQov7t+JpcNuUs/uOLmyf8QSzpXq3NnOU+1s+QYri8yOVwYoJfaCquFKPCU
	MlAyO0PIh5xmuUBCXJyWP5ZPUWaMQMDiA5p8SDXRqf6qAF66oWKYSu+gHc6agQCj79mFFYffh82
	E0saXEn18jpgKzMwOP1FISLLyd7egM7RZuKPU2XzA9n1v//+cM/ZRJh+6yRxEtWCz/z+PdmARqA
	uytI2Z8qbdGI+fRCmTf4qqqAHC/tK3ZcYvHGVD5Xe2hlXi28eYrvvxyG6ooqIMsXV9yvVN0tK8i
	szK/h1JyPb9IjmvlmRgis3TOKbxFuhA8u7NyqVpOa5fyjj4YXKANloOTrhgs6mV4Dt7sSd70/Tc
	mvYAVdz8Vq/87VjbZn5PYG2epiNNsMktdRw3+wxsFvjdta83xBhSTfLje7EyB9zmDvoGIPrFeQ0
	kg0wiODVdLnQLhz1JJKbIEBTaVZc7gGJHMfGQYih0LziXqDE59JEmHGeFbk0EjCvDrNFXvsAx9M
	nb+nniJE7w==
X-Received: by 2002:a05:600c:1d0f:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-485566ca95cmr267107525e9.5.1773744845991;
        Tue, 17 Mar 2026 03:54:05 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bd1b8260f3f46ac.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bd1:b826:f3f:46ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856e850634sm105395885e9.0.2026.03.17.03.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:54:05 -0700 (PDT)
Date: Tue, 17 Mar 2026 11:54:03 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	shuah@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/bpf: trampoline_count: use dedicated target
 function
Message-ID: <abkyy4ss0q4D7Y2l@mail.gmail.com>
References: <20260315054227.118344-1-sun.jian.kdev@gmail.com>
 <20260317010209.8779-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317010209.8779-1-sun.jian.kdev@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268555-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 902222A851A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 09:02:09AM +0800, Sun Jian wrote:
> trampoline_count fills all trampoline attachment slots for a single
> target function and verifies that one extra attach fails with -E2BIG.
> 
> It currently targets bpf_modify_return_test, which is also used by
> modify_return and get_func_ip_test. When those tests run in parallel,
> they can contend for the same per-function trampoline quota and
> cause unexpected attach failures. This issue is currently masked by
> harness serialization.
> 
> Add a dedicated bpf_trampoline_count_test target and switch
> trampoline_count to use it. This keeps the test semantics unchanged
> while isolating it from other modify_return-based selftests, so it no
> longer needs to run in serial mode. Remove the TODO comment as
> well.
> 
> Tested:
>   ./test_progs -t trampoline_count -vv
>   ./test_progs -t modify_return -vv
>   ./test_progs -t get_func_ip_test -vv
>   ./test_progs -j$(nproc) -t trampoline_count -vv
>   ./test_progs -j$(nproc) -t
>     trampoline_count,modify_return,get_func_ip_test -vv
> 
> Tested-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> 
> v2:
> - add Paul's Tested-by

FYI, in general, unless there are merge conflicts, you don't need to
resend just for the tags. Maintainers can apply those when they merge.

[...]


