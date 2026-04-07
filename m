Return-Path: <netdev+bounces-275931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP6UEMnX1GlxyAcAu9opvQ
	(envelope-from <netdev+bounces-275931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:09:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E04BE3AC8C4
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C88643038A4F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CEF3A782C;
	Tue,  7 Apr 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLa/waDt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8jes2Ew"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92383A450C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556519; cv=none; b=ibalQQW+/rTMVnAjCvEUqw84S+s4+vuu3dzqEmLOuPUMI8xb8A6C73DBJp03JiSIcF3VMX8IPX64nZl1khCNwv+f6DVFj7Vvmd5xYTkB7rPQ6jLrlhD5ryXvqsuJZ7EZJgaCyJhk2cJ6q9PK3cVXi9mPstZbEP8N5oGlM35UdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556519; c=relaxed/simple;
	bh=R9vZ3elU3V/8wueZHLI+PW4ahWXh1+tFL5xZ/WFiw88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6XYu74DKfIYy1a3YRr3IjAfCaYt99mK6EJ87SAPjCgAJOwH9XbWf8oAF0s3/SgJmih9KBAKQHB0j5K86JMRseU5AhVpLQG463K3AaNnCpcrqaQrQ+aKccRX7q9KxFQMxHYmGZ7BdLYeVNyPgGkNuW01HoBsY8GL0c4OWJqpBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLa/waDt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8jes2Ew; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775556517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPcG9Tk4uGB6LgSxC9DcNHhtfMDfGqAMPkqOmu5DgYI=;
	b=BLa/waDt8PZFRC2LSR+vu1hFpzz1+w7ohSGN0I3szS1ctcC404vPCTaivre4CeWYilnvcY
	7Mkl3xl5eYIV9KD4QkuVwAR3BxvQ/iPZ01lRYq2+0dWQ93qEPD9l+TSB+7wfkW7gcxYAUR
	SuFSjuWS0CfMXLfWvoDWXVkRhWtbo4g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-0AQgCcVPPyCb_MrbScn15Q-1; Tue, 07 Apr 2026 06:08:35 -0400
X-MC-Unique: 0AQgCcVPPyCb_MrbScn15Q-1
X-Mimecast-MFC-AGG-ID: 0AQgCcVPPyCb_MrbScn15Q_1775556514
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488bf01961cso3172305e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 03:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775556514; x=1776161314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPcG9Tk4uGB6LgSxC9DcNHhtfMDfGqAMPkqOmu5DgYI=;
        b=M8jes2EwdqliXQmR28jCAmpye8JSHnU94CDurVBZCR7cvRCZJGpUVyapC2DvX7pElK
         ydlbDHOPn+eX3SCc2fp06QogmDAML5q0IPsNLgEZYroAwsR0kTKc4ve7dsyL8XFJNlit
         5Z0FyeJ2fLX473lYmaMXc6K0K04hQ8CbKajqxowB9Z0QQIAShszM5/T/ZS6XmCPlyCJp
         fMElS+iRfsw5pkl7bZZIpO418/aDoOJQgKjWvmRk9RO9vvK52iKyLfxuKwRbNtEuYx3a
         DgsH2Q2GT2WkiHPCZsk/AuLrNzFMpf3YB6KwvShUuwGJm0PfM/OB3f9jv7I1vwvzbVXi
         R+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775556514; x=1776161314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPcG9Tk4uGB6LgSxC9DcNHhtfMDfGqAMPkqOmu5DgYI=;
        b=YALUolXT8BhqlyKIV63gFgQB0dgXBiBO1zgZP9YnxAOoEL997ADzl29OEkeVvBiO3l
         zLYL4Wbza05aTWgsRUe0+bd59pWcotACjOOEKLVMytAMJ6JpoBXgYDdOaid27zrhQdCH
         JPmpte9NhtLDnvcFu3XCCLBw+ZOJE8ams3P1Vav4Fiz7/6MU4VgorIKLJvj8syS7mBXP
         pcBPyc0OBOSS4md7oDSS9F5tFYoKc5g8vfGuGJEoH1rkEs5UK76v3tdMAwuhuycN6MQv
         z1wSThPUw9KMde9Q6qslP/mB1xNbiQ516xyEIssmTkKZwpMbOoUHk6XulpRTUJBK7FTo
         kfww==
X-Forwarded-Encrypted: i=1; AJvYcCVPsBRww8WpcbBKn7RecUgAVPy5VSw8/37dKz7I17ZVuDH0/skwBTpcQiz5ooL/1pw8TzcxlwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItflTp+qNhRS43anNYcUo7DjBB7hFHMap01FeQml8DA6GShbh
	K9BZ+zJQPji+8+49jhSpQ/WJGIipqC4HcbH4sCgPirqo8AsYUwhuzoY/ZoW6ya2yq48bIXx949j
	lX0rYh9F4JdDmSVLWJxEo5fOCNau3qviECgGc0eRtPit6NR8UBNJzyKPPfQ==
X-Gm-Gg: AeBDiev+qta7dOeRhoPv9qAeu4IYCGrt0DsDCSuaBUux7ZRzgUEsuXoq57igBjqr+gq
	9yvLvjSfrQQGUXQYtLinyly0QWUjQzsXE0yq5SMpdMRjpBnJBryLHr6sbI0tH06liZ+smd+0NOt
	8HMvgq6xpLy6Z3sv95OIUjk+bhsz1CpU4Jh8ICroZoZLWNbDj0K6CSW6dSjNT8h8un/epHJ99qD
	IDDzjNEaLSed6qb0KHOmEAxxYrcWVvfcwtanAwxK6LkRUI/wuUbsJHtXbRVVF8QdietrNGqVjxy
	w5Qm2oBWs5faU5ChLu9K7z3NcUWfiCdZnNp0K/iJVwmuJ8+AHIrKy2FduQzTx4EdvozK/zjiY52
	vTEwTOZ5lAkaeeezaai+a1AeYZ4yze/r6SOlXuoqQeJi9M4wtWP5tmFdi5A==
X-Received: by 2002:a05:600c:e40b:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-488997aafe8mr177853445e9.20.1775556513874;
        Tue, 07 Apr 2026 03:08:33 -0700 (PDT)
X-Received: by 2002:a05:600c:e40b:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-488997aafe8mr177853105e9.20.1775556513445;
        Tue, 07 Apr 2026 03:08:33 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm531203475e9.12.2026.04.07.03.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 03:08:32 -0700 (PDT)
Message-ID: <3ae4bb0b-6f4c-4477-9c67-f2122eedad8c@redhat.com>
Date: Tue, 7 Apr 2026 12:08:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8] selftests: net: add tests for PPP
To: Qingfang Deng <qingfang.deng@linux.dev>, linux-ppp@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Felix Maurer <fmaurer@redhat.com>, Petr Machata <petrm@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Dianne Skoll <dianne@skoll.ca>,
 Jaco Kroon <jaco@uls.co.za>, James Carlson <carlsonj@workingcode.com>,
 Andrew Lunn <andrew@lunn.ch>
References: <20260403034908.30017-1-qingfang.deng@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403034908.30017-1-qingfang.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-275931-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ppp_common.sh:url,pppoe.so:url]
X-Rspamd-Queue-Id: E04BE3AC8C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 5:48 AM, Qingfang Deng wrote:
> diff --git a/tools/testing/selftests/net/ppp/pppoe.sh b/tools/testing/selftests/net/ppp/pppoe.sh
> new file mode 100755
> index 000000000000..f67b51df7490
> --- /dev/null
> +++ b/tools/testing/selftests/net/ppp/pppoe.sh
> @@ -0,0 +1,65 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ppp_common.sh
> +
> +VETH_SERVER="veth-server"
> +VETH_CLIENT="veth-client"
> +PPPOE_LOG=$(mktemp /tmp/pppoe.XXXXXX)
> +
> +# shellcheck disable=SC2329
> +cleanup() {
> +	cleanup_all_ns
> +	[ -n "$SOCAT_PID" ] && kill_process "$SOCAT_PID"
> +	rm -f "$PPPOE_LOG"
> +}
> +
> +trap cleanup EXIT
> +
> +require_command pppoe-server
> +ppp_common_init
> +modprobe -q pppoe
> +
> +# Try to locate pppoe.so plugin
> +PPPOE_PLUGIN=$(find /usr/{lib,lib64,lib32}/pppd/ -name pppoe.so -type f -print -quit)

Minor nit: here stderr could be redirected to /dev/null, since the
command will likely emit at least an error message on most systems.

Could be a follow-up or added if/when you will expand the self-tests.

/P


