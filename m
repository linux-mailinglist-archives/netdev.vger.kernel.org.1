Return-Path: <netdev+bounces-277300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBKWGxC32GnnhAgAu9opvQ
	(envelope-from <netdev+bounces-277300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:38:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AB13D4325
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1850F30057A9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B569E3ACA65;
	Fri, 10 Apr 2026 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqQjo4V/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrtQaKx7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A339E17E
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809993; cv=none; b=Jj0s+x01boWYJmhT0WPkyNhv4PHvRBdDo+7/WkdysT7+eq6YCyU1zpUk3iwahwpFippcOpxPHqgQnJISoAy2f83EuJaxbCHAYkMpsKwg7CtQgN7rG3ofs7w0HxYmBdzrMoP2RuPZAZMYpmfqfSF6SOSDBBKZ89IrwB0LNoVcYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809993; c=relaxed/simple;
	bh=3P3Yp7kZAgzbJGxtHzxC2EX0OREVvZPZwUK5CbfY+SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHKilJ6vDRC1sE3VONA/LL7We0sY8gAbJeJnRckIUtj6It2jGwtXphu2i0zKj7gWobpNihCT4yn3KuCFUbYDbTRYtfSlVxICc84x+VDlsRDlK6DcBcRstgQBXyRIzivZllDmrZ58YZH47aXiZMWzYAdJwvwR5Z7Vz5bq/TeNC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EqQjo4V/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrtQaKx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775809991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbV+a2kN0fqhbaSyrzX6IchPn1p4RqFKSu0TwhqfCNk=;
	b=EqQjo4V/BMjG9wgzdaYDd/c9EiH0XhApdLGZke6CdJrHLAK9AZSSJxBPtuzU2wE5XvgTMY
	WSkZ7kRdDl9TUVVvPwya1WTYp0G+1iicGREu8KGFjlhD0Wu+y0d0wwftWLoEvx7X7eDQwh
	27r4LLxWloS/lgFR4qR0HPd7dVtfJlg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-7QQ5BPJaO-WoGiOX1zegjw-1; Fri, 10 Apr 2026 04:33:09 -0400
X-MC-Unique: 7QQ5BPJaO-WoGiOX1zegjw-1
X-Mimecast-MFC-AGG-ID: 7QQ5BPJaO-WoGiOX1zegjw_1775809988
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488ac66236bso11039635e9.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775809988; x=1776414788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AbV+a2kN0fqhbaSyrzX6IchPn1p4RqFKSu0TwhqfCNk=;
        b=UrtQaKx7UDHS0qzc2oIghv70modh1UUgsZ9y2ulbSGDwsolLOusN4l0t55GLna/c7x
         xgcvb0hfG4ZrXvc4ENx12Vy2bwA/nsA7/tJc1qBbBJYZg6tPp73jHgfiWMS8SbIxLiAf
         U8jXbb89uAjigiORrXkx4mVkvDLGHDk+Em7rjpMvWeTlDddu7Ug0PY8sKjbieRqWkBPN
         OWthFcVKSGZrrwkvX1oFixjQ2yrNyAcHn50riRgqyxx/Ijcv56FgvKFQxbRH0QPHaHFo
         etZbDA76EPr3MkOjbLk6CwpmJlcERY/PuPgTsI//XIxe5rg3Fxv6EFsdxUiA5cdqupWv
         g87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775809988; x=1776414788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbV+a2kN0fqhbaSyrzX6IchPn1p4RqFKSu0TwhqfCNk=;
        b=q8mbQSRgPT3KIDxaevlzGEFU/W/10D0fcVsr8LwYbV3uvDxWPc+fAtzKG8QZhR5vc6
         +WV7EfdIGXy+7b5JGw7VrpENSKRO3Kl3/3PhKVeWgEQbWgx0zkofGHeWuMt0gQCSMOHI
         3UQeTQyWztUM1GdXsQWvWNW2nfljnjFMbAGlOTGl/IstAmAigWKpQZIo7P33CCccYXEi
         /2Qw2Fc2S6TuIwzNLLuWZgHUTDSASAM9vhDjUi6ZZ7bf5Y8QCyt89WulOSQFyyhpMozE
         6ZSyFn3+iC3ERl+c4KatqMXfnOtAJ3WyKWppaLenESc8H000VSGB7+TcfrLWF9wW/icL
         TXTw==
X-Forwarded-Encrypted: i=1; AJvYcCXaDqf8Vqscl6oJAxWJdvuPYVbibRLWvwofkph9efpVdWrTsWjv6JjYW2BfGubIjmR0561Dhss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZlVZ580L0h6jcnrtUNiXrfipEBEqZ9vffUVoasZ7AwdgN9oD
	6Knp/tnpa4bM5o6Ek0ATwYhhWoR6X+XrsZJGcWtQzd2VTvXruAlC4kfTGFIsqGwf0FKIW3dxz+Q
	hcDhKHXxFMf8nQ2lBl94mDilDifb1l041q9eDKGn8j+EdLEtDIDnKOiuR8g==
X-Gm-Gg: AeBDieso5JyRs5WyCAVKqzbRePkHhrrfcZMV6j5K7wdOt4xAqZSRfcQweCG8H6A4tHp
	Z8vnEZ7TpUkOQLwQ4KaLhu6M1kTUEDvYJ0LmML3SN2eSZ0O+JMaZIO5VSWyIBTHmGqP35h2/D6P
	75Rnm4ByBV0KRfFrw8NR7ePokARPK6M4T/uCqVT2X5qzclecZaAOYtTOAlCuH2IV+druZeHzdWW
	wjeRE8lTYmPSKYsrp2ovwEpi/QrqLbfJwVyqt4gSaTiBm40WNnOV/Dg/RbJvU2JyIrIcPriKho/
	lLfA6cNgLHYoq75T6ND/Bdjy59pL4ncO7Z8m9bArQzR7ivAoKvSkEfMXI5yM032mxeV4psJvn4f
	N566VRPbKTVm4BRQNcoV9pjNifvGUAbFbjHfe27+9L5R/g+iIVShTjsd3VgHam0nWw0Qq5ODd/Q
	==
X-Received: by 2002:a05:600c:c10c:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488d68cb8demr15409455e9.12.1775809988198;
        Fri, 10 Apr 2026 01:33:08 -0700 (PDT)
X-Received: by 2002:a05:600c:c10c:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488d68cb8demr15409165e9.12.1775809987691;
        Fri, 10 Apr 2026 01:33:07 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3c597sm53013275e9.12.2026.04.10.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:33:07 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:33:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cao Ruichuang <create0818@163.com>
Cc: stefano.garzarella@gmail.com, shuah@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH v2] selftests: vsock: avoid races creating Unix socket
 paths
Message-ID: <adi1X_3wVUsDhRmR@sgarzare-redhat>
References: <20260405195733.86043-1-create0818@163.com>
 <20260410035237.59644-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260410035237.59644-1-create0818@163.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277300-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11AB13D4325
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:52:37AM +0800, Cao Ruichuang wrote:

No patch description at all?

>Signed-off-by: Cao Ruichuang <create0818@163.com>
>---
>v2:
>- retitle the patch to describe the race being fixed
>- replace rm -rf with explicit rm and rmdir cleanup
>
> tools/testing/selftests/vsock/vmtest.sh | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 86e338886b3..c345fa539d3 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -718,6 +718,7 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
> 	local pids pid pidfile
> 	local ns0 ns1 port
> 	declare -a pids
>+	local unixdir
> 	local unixfile
> 	ns0="global0"
> 	ns1="global1"
>@@ -736,7 +737,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
> 	oops_before=$(vm_dmesg_oops_count "${ns0}")
> 	warn_before=$(vm_dmesg_warn_count "${ns0}")
>
>-	unixfile=$(mktemp -u /tmp/XXXX.sock)
>+	unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
>+	unixfile="${unixdir}/sock"
> 	ip netns exec "${ns1}" \
> 		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
> 			UNIX-CONNECT:"${unixfile}" &
>@@ -758,6 +760,8 @@ test_ns_diff_global_host_connect_to_global_vm_ok() {
>
> 	terminate_pids "${pids[@]}"
> 	terminate_pidfiles "${pidfile}"
>+	rm "${unixfile}"
>+	rmdir "${unixdir}"
>
> 	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
> 		return "${KSFT_FAIL}"
>@@ -814,6 +818,7 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> 	local ns0="global0"
> 	local ns1="global1"
> 	local port=12345
>+	local unixdir
> 	local unixfile
> 	local dmesg_rc
> 	local pidfile
>@@ -826,7 +831,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
>
> 	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
>
>-	unixfile=$(mktemp -u /tmp/XXXX.sock)
>+	unixdir=$(mktemp -d /tmp/vsock_vmtest_XXXXXX)
>+	unixfile="${unixdir}/sock"
>
> 	ip netns exec "${ns0}" \
> 		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
>@@ -845,7 +851,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
> 	if ! vm_start "${pidfile}" "${ns0}"; then
> 		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
> 		terminate_pids "${pids[@]}"
>-		rm -f "${unixfile}"
>+		rm "${unixfile}"
>+		rmdir "${unixdir}"
> 		return "${KSFT_FAIL}"
> 	fi
>
>@@ -862,7 +869,8 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
>
> 	terminate_pidfiles "${pidfile}"
> 	terminate_pids "${pids[@]}"
>-	rm -f "${unixfile}"
>+	rm "${unixfile}"
>+	rmdir "${unixdir}"
>
> 	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
> 		return "${KSFT_FAIL}"
>-- 
>2.39.5 (Apple Git-154)
>
>


