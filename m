Return-Path: <netdev+bounces-277306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGzhNii+2GlVhggAu9opvQ
	(envelope-from <netdev+bounces-277306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:08:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 866393D4869
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 791B6304D250
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0750F3B3BF1;
	Fri, 10 Apr 2026 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBK7lFu2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WILM026P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F203B3C00
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812010; cv=pass; b=nu6Xr+3ZJtCWcec3+ckt7o6sDnJ+9GqrqjyOKsCij/AXUkNG6VdE2uBPaUu9m5yNEeFAksZ66iv/7qLDzyoC/S4jUNXHAWHsR4cn0lotoUzfoxLCcIMBDCUl3IDy8o200nHaiJXhq2AJvgA8Jmhkr7+DSZz1BNn1nnnTRxkY69Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812010; c=relaxed/simple;
	bh=mkRB3+rS1m3805s8GQTj2HfkmQ2P2SWXAkPM7ASB7ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLTavUxHmPlc456GLLMbZ0WCzcdP3/obHAS5vcP8aqNqY+EPuY6AFPu5wCYFfgVjRbeFTZWLAY6EaBuR+EAJxAi8CsTDQI3OmmsLE02nmn5iErq2j7JgYoX8FldP+c+mz00wJUUgZTzMbJ50bsRO1DKWTxX33gcemHQy54a4Ry0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBK7lFu2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WILM026P; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775812007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfU0YWSJIfl9AQo8fY3otc4QhRCrsnnfRWzfq3Ua0cM=;
	b=LBK7lFu2hAYD57dNrwiXfUCR91vVRYRAPCXLRLb+/lH+0TbCCEVnflGewXfjrGpkyA3tEB
	FIbmT++PY6WA1jleKSZ93V59/izmch5hfN+xwelf3v5NVO31mzYejU4dlUJOj2JJQZNllC
	BxibLHqM0lUNkpGRzYxyz4r4yofau14=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-bvwkRKORPUeW-wBZ7nuEWQ-1; Fri, 10 Apr 2026 05:06:46 -0400
X-MC-Unique: bvwkRKORPUeW-wBZ7nuEWQ-1
X-Mimecast-MFC-AGG-ID: bvwkRKORPUeW-wBZ7nuEWQ_1775812005
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2471321dcso44437485ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 02:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775812005; cv=none;
        d=google.com; s=arc-20240605;
        b=IjLmQ5p1Ubn/m0mPSjzBnk+aVD6gYMWPWhn5atu/r6G+uOubrpMqoZmtmlq5M8HRH8
         T4waVor7RuGUF6u6HO8i93eW3x8y3f7hXuB9xxpShaWRlj9s+DL2n2t0Zi7Wh/cC+MWl
         TxD9UV5RNlayhdsrGBaMctFBYJQV5JSmhG7fSwA+v9tVe8DLBEwBcdT7lp8HZYQsCzGS
         17zlWnPjerjSNwUTqYE4o0Q/vtviNe4wXmV7UtHulZWQxayLApBcUkhpchX0UjWIprWC
         z66uuy/6gDF5pvwVTs/gRvj2j3OG5KYD5T7zK+V1tO7hRlCCkpAhE0+9HNoynPtL9gvk
         REEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MfU0YWSJIfl9AQo8fY3otc4QhRCrsnnfRWzfq3Ua0cM=;
        fh=6hMFfwdgnUwaZriI8pORDu2itgwnWkkQjNyaSU6crp8=;
        b=gNvMrKybkykXMEGW5jc7zOEGbS14eZCTfiuVTWu0EKfRMKLQi9e7awRzDziQ86ftWZ
         mu1GD2/zoNJjlkHIRHXpdLEL1x3nMDIZRCjcd0gr5tRseT84cekbOXyiSH8JyAsrUFKi
         KIJNk+wT9ciIupmVcCkkMX5yHt371P3Gcl9T18WIi5T4YAUtYuPU047GbcJn1DAmQ5Zs
         dlmDbEPzP7zsDAp0FZ2LfensqTv5eWgrbknPItLOoEzPC9iL7+9g5TMbO3oq/o3SyH14
         4oLQ6hx/5O/0KD0+k1S7QPU9dIzq20siagSpWZ0zeEI9WZb8hsV4H2m4444uc7GGjzct
         GrpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775812005; x=1776416805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MfU0YWSJIfl9AQo8fY3otc4QhRCrsnnfRWzfq3Ua0cM=;
        b=WILM026PYc/l5G2KfbB7RfZm9na8Mqf8laBdNw6cnssEy8c45BBYc0WxvNo9qVZsaX
         KbeJgCgGhBZ+jvBZ6lmtdMrSaP0NPD/LJ6wKbSg05/IPNQhDQ1nGwV3Xu3PvkE/JcIpW
         0PCaQflU9A9WfYLwlf8W9L8s+eArPqGIDZogPGzIJCDG2/e4qR+94YD81cs1cOMNHTxL
         +1iAJ1pJrF0Dsak34InxtSpIIyNrlVlpOaOBzsu3sAA5zm6xIszQRKjU5VrD31YgP5hB
         50emK3crxvFQWpGnHnYR5w3vZQqrOLbFm3nRXpa19ZJUyWQUDk82r/EI/msqKJ5NTjb3
         D8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775812005; x=1776416805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfU0YWSJIfl9AQo8fY3otc4QhRCrsnnfRWzfq3Ua0cM=;
        b=pJ7JHOx0ovdWHCHo9LENycdnJZ6haCNdIu1kXHnCm0WrXjGyuDpRZ8dXu6qssCI53c
         3eQ7hzjqTgOzrQJuHRrI9PP5VVwhRP1ushTkfF5Y/mPrZVWdL5QldNifeG8tYDJyReXt
         4kFaxIqbVdn7Q5Xzy+zHOXC1yCA6qnO32OQvUpSpgfBEw2UIxfU6Ic7ZjZ6Ub6grDM+p
         e3EEBsY1yyMztwaRVjqCO5/puSNOR+QUuznaGUAWNecstQ1Fw000Zc/Q9RTOwcBdhfeX
         jt1Skd/gPuhS1GkDYvjO31z2vcS9yCy8oETvHvYymGIaHEO/JlloGjo1xsKDPlDa/jJ7
         4/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkL0C5VPIBHFjkvsvqC8RIxMeJ8VAFQosHUKFzy5mGlo7M6jxAvEvi+ixW1CpIs51tRYEbcQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx73yaWTtKoCTY3BHI2MY+vBnwDmHz+JUjpSn0Wbuw9jqw4rAho
	jsq+ph5p5+i7xBi7y9h/vmfssEHHMV0bCSptKpVYqssXlh7wHI8WOOMREkSq4C1m3t/nInJS/ML
	JNRIGrqyCzZFkWb4KkxdglyGBsB9bCyobJhWx9/1Rfozd7GKzxJkaeOOwWCk96M60MrviTeXYnU
	3XfzXGWdFFicM+L4F+6W1Z536y3GgsF1kV
X-Gm-Gg: AeBDieuZJXiSGHkChj7KUvnRTjvIy9Gk16wSGvhDSVtf/bQzBUqSlBdbJTh07yMFeUs
	S93/+Yev4YDLc8l6YdmYB3f0cTp3M+BZVAXr//49mRuRmXnSa5VwzSUutu+uTYZ1coMNozy/Dh3
	MfUK8OhWowRQRBXh6ncV7jN7xum0G315a+twcXQEDtSjgIeWNjQ5WwLW4sCXQxLlE7n+wuePhke
	cmsSg==
X-Received: by 2002:a17:902:f0ce:b0:2b2:41a9:8e10 with SMTP id d9443c01a7336-2b2d5a3c39dmr14965775ad.23.1775812005187;
        Fri, 10 Apr 2026 02:06:45 -0700 (PDT)
X-Received: by 2002:a17:902:f0ce:b0:2b2:41a9:8e10 with SMTP id
 d9443c01a7336-2b2d5a3c39dmr14965435ad.23.1775812004685; Fri, 10 Apr 2026
 02:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405195733.86043-1-create0818@163.com> <20260410035237.59644-1-create0818@163.com>
 <adi1X_3wVUsDhRmR@sgarzare-redhat>
In-Reply-To: <adi1X_3wVUsDhRmR@sgarzare-redhat>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 10 Apr 2026 11:06:33 +0200
X-Gm-Features: AQROBzDVhsz7kNUJ36YTaPNuvynQFY-Dt0FMLOERsUNJeRpJCN7EnVLjvVRFZ1o
Message-ID: <CAGxU2F4XpzQiKwboQt9UEpxY+Gzsq7qyR5CMLZO4F_hGqTpndA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: vsock: avoid races creating Unix socket paths
To: Cao Ruichuang <create0818@163.com>, Bobby Eshleman <bobbyeshleman@meta.com>
Cc: stefano.garzarella@gmail.com, shuah@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277306-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 866393D4869
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 at 10:33, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Apr 10, 2026 at 11:52:37AM +0800, Cao Ruichuang wrote:
>
> No patch description at all?

Also, maybe better to CC Bobby.

Stefano

>
> >Signed-off-by: Cao Ruichuang <create0818@163.com>
> >---
> >v2:
> >- retitle the patch to describe the race being fixed
> >- replace rm -rf with explicit rm and rmdir cleanup
> >
> > tools/testing/selftests/vsock/vmtest.sh | 16 ++++++++++++----
> > 1 file changed, 12 insertions(+), 4 deletions(-)
> >
> >diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> >index 86e338886b3..c345fa539d3 100755
> >--- a/tools/testing/selftests/vsock/vmtest.sh
> >+++ b/tools/testing/selftests/vsock/vmtest.sh
> >@@ -718,6 +718,7 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
> >       local pids pid pidfile
> >       local ns0 ns1 port
> >       declare -a pids
> >+      local unixdir
> >       local unixfile
> >       ns0="global0"
> >       ns1="global1"
> >@@ -736,7 +737,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
> >       oops_before=$(vm_dmesg_oops_count "${ns0}")
> >       warn_before=$(vm_dmesg_warn_count "${ns0}")
> >
> >-      unixfile=$(mktemp -u /tmp/XXXX.sock)
> >+      unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
> >+      unixfile="${unixdir}/sock"
> >       ip netns exec "${ns1}" \
> >               socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
> >                       UNIX-CONNECT:"${unixfile}" &
> >@@ -758,6 +760,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
> >
> >       terminate_pids "${pids[@]}"
> >       terminate_pidfiles "${pidfile}"
> >+      rm "${unixfile}"
> >+      rmdir "${unixdir}"
> >
> >       if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
> >               return "${KSFT_FAIL}"
> >@@ -814,6 +818,7 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> >       local ns0="global0"
> >       local ns1="global1"
> >       local port=12345
> >+      local unixdir
> >       local unixfile
> >       local dmesg_rc
> >       local pidfile
> >@@ -826,7 +831,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> >
> >       log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
> >
> >-      unixfile=$(mktemp -u /tmp/XXXX.sock)
> >+      unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
> >+      unixfile="${unixdir}/sock"
> >
> >       ip netns exec "${ns0}" \
> >               socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
> >@@ -845,7 +851,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> >       if ! vm_start "${pidfile}" "${ns0}"; then
> >               log_host "failed to start vm (cid=${cid}, ns=${ns0})"
> >               terminate_pids "${pids[@]}"
> >-              rm -f "${unixfile}"
> >+              rm "${unixfile}"
> >+              rmdir "${unixdir}"
> >               return "${KSFT_FAIL}"
> >       fi
> >
> >@@ -862,7 +869,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> >
> >       terminate_pidfiles "${pidfile}"
> >       terminate_pids "${pids[@]}"
> >-      rm -f "${unixfile}"
> >+      rm "${unixfile}"
> >+      rmdir "${unixdir}"
> >
> >       if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
> >               return "${KSFT_FAIL}"
> >--
> >2.39.5 (Apple Git-154)
> >
> >


