Return-Path: <netdev+bounces-179651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 344EBA7DFDC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E8F3BBBEF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7D18C907;
	Mon,  7 Apr 2025 13:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2018132A;
	Mon,  7 Apr 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033259; cv=none; b=dzXC5o3ljOjN75MuMMhc2YNZVEjG7eYgMiyg8WHdqBLBJLlYhr972uAM/nMqK99BlPf493ob6J3N43TOvIMfwhwTJT9QQIHcURofHKyH9DOx9kT0JUvv3C2qhMjE0hJ0iMu1xosZcbfuZNFxssZ8lA0sYlu56cepeHr35Hnrqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033259; c=relaxed/simple;
	bh=01EglMpD15y2ymKpcfvYYvSAPDlSLNVF+4BeO1FGO+0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EZDFVX/wJnWOHq6V7J/jkgq1l67TUQZSMTbW8Io++0tuVrx/ACDlAxn0iIdLAy/GTrz5DxmRoNv9Zv6r3TzS+BEmbS5jLJglJSPKgMLuUSgW1GFw+03wVd9XXfibOqDiUu7Q0pnHQjDRLkT5VAp4KEhIRUH81GnMw2GCky9RGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso5955281a12.2;
        Mon, 07 Apr 2025 06:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744033256; x=1744638056;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2AqJDaf6lftoEu9Q+iVLTJdgR0Iz9hzEE7Xh9FUmiQ=;
        b=bXdEWrC7xcYAnXYQGa1weRg4jZPB68naB2VpKHxzLpSH+OhAZtzHtIqeKNtgFfKrZW
         5rpwJjwK3JxVn9jaNsJWZjO9HUs7pAXmmR66VrMunHkp04fnRGu+RTwyvkkuNBlzxhtn
         Y5zISkT8qUWEtQIGlTauWj8A+B1yPNFJbnvGhjqIUYvTcnnNwsEcPiSteEP0g+leBuHy
         IrrOvQKT0qTsnCo3tflq5gHuYO+G/6j0JeXqNL04m0EzoJm4I3II6TvqwYk5ngr9Ow/9
         k2d6evfG5PlNkx31CQh97033on+dzFpXWLkUlm9pXUq45CLvOPW1Zlm/w7bO5KpUaJ5l
         d+nw==
X-Forwarded-Encrypted: i=1; AJvYcCVO+Ym0w3b/SJ5EIdkrjyJ0Et7hxhKTtiaeaOhELu069UcK/2qcocWD7eQrIUH7HCYrz26yl89DE6Bu+gU=@vger.kernel.org, AJvYcCWo2l7Xru1HR0eNFplqlbS30Y/ol9ecXXojjEUrq97D75vmK8McIhpyq9mUAUMaXgc+EJmX1Q+E3KXPwfF7LOYsWLLI@vger.kernel.org, AJvYcCXpgbNpOOe+x5sWxVZb5KpgN8tv8kl9xkCD0R3TyuUlbv5AUaW20ijqIHRXa3fgVg9tK+EK9Qg0@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPG+WBgPEooTyp/riw3zWsm5IUx8jLL7eLQWJASWki0hwlsG6
	pK2pc8YQyATQcJ2XqEUWmTeOcgLESg6rYUnLmv+VjjtLQt337TS8
X-Gm-Gg: ASbGncvvkNsSc73UtHeR/T4qAzjoMWy1MMGCnlLLVmgDFXUwES99Kpb+pqgNivRa3Fs
	Fjg0re/q+PXHEiWSzpjXDU8NgZwPx1mY6yuGKHcNOehFzmmrRXk8MsuSrrdZwYYEjFShCGl9h+f
	pf/be4DNDuOra4LNNSXwXEIXl7G16Q2ds65+4+W9i4QW5uYlyIApTb/c+3qGWXfvkQ4m2CjPmpT
	uUAWdI1DbXiNBSqw4JIE4SBpTNJbjouWgvfAREGXKWefH2AiLLNv3q85bsRvWbMoPxdRr8ZmeBY
	ya5+uxqd1QxhCn37eIDKIuYk7qMextKlvFA=
X-Google-Smtp-Source: AGHT+IFmsL1euGq4gGWgwaUT0FPZda09D+NQbhymvNQBlBKHS3i0t1fPWGZou8NTao96N1nDJ/xr6Q==
X-Received: by 2002:a05:6402:5112:b0:5ec:c919:1b7c with SMTP id 4fb4d7f45d1cf-5f0b3b630fbmr10172486a12.5.1744033256115;
        Mon, 07 Apr 2025 06:40:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088084dedsm6930393a12.49.2025.04.07.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:40:55 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/2] trace: add tracepoint to
 tcp_sendmsg_locked
Date: Mon, 07 Apr 2025 06:40:42 -0700
Message-Id: <20250407-tcpsendmsg-v2-0-9f0ea843ef99@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANrV82cC/23NsQ6DIBRG4Vch/ywNoNaWqe/ROCBc9Q5FA8TYG
 N+9iXPnk3znQKbElGHFgUQbZ14irDCVgJ9dnEhygBUwyrTKmEYWv2aK4ZMn2YzKmfretTp0qAT
 WRCPvF/ZGpCIj7QV9JTBzLkv6XpdNX/0fuGmp5eC8amrfPr1/vAIN7OJtSRP68zx/LUjRR68AA
 AA=
X-Change-ID: 20250224-tcpsendmsg-4f0a236751d7
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=leitao@debian.org;
 h=from:subject:message-id; bh=01EglMpD15y2ymKpcfvYYvSAPDlSLNVF+4BeO1FGO+0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn89XmAJAEDlARnpLVgNYtcLThbvasYRmS1mvsS
 K9tUWxDKr+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/PV5gAKCRA1o5Of/Hh3
 bWbREACuCoecsHYgStRm61a6ly1WdmfIF/Q2d9e/MqwAohn2ZaaMDwRLJUdepJ0jQh46XB1nPIZ
 A6tLmxuK2nYceZ9J1CwOcCP8Xy96QflFgN98iymoqJgrydu9q6CBFYfXgrH0as78ITpFTXhbCCB
 BwvxNt3PfT82cmZmVRkw/eGJq/F3ZDO6yXUQ1RyZAgB6YHoUzlDmeC+Vk+xpl1f2dlmo6l5R1nb
 Baql/UaiI5jGu1/wWSMfi5QM89EYoUqtOBl/mEde8KOi7fdFeo+xpgRIW6ew+dhx3HX53mGrI7g
 Aw+U2yuIKY7tpSYzgYLafVHym8zlO/AslDL/sjEOxe3B9twGBB/Fd6RHn6a/ilcb3KEK6AoPSHA
 YLBwbrslqF1QbbNY0Jkqtqno25EVkDgwBv/K5W7V7dx8i16yM8H/vAjJC9fTOLXxnpVNsFWqpgJ
 /7kmNxd9rr1UpeKjZJdC3tax5LsGn8Mi7OmpC71KyCwbSNNdSMkrAYOzRrlDzjoh7EF9hezhIeh
 k8e5VWOR85k/LI8IKgS1QaitysCQkl1gfrAuijTj+bpoA/iRhkdoONtuGsuqcHgTbAeiji8ARko
 3WwGNUPGS0K5/bQQI3UHZtZdcbCkd/5i+wrWmgWIr/r8Ms+PcuLveGm720p2AZ0K5+RXbImZIGz
 98eh7gQu5yWBW3A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Meta has been using BPF programs to monitor tcp_sendmsg() for years,
indicating significant interest in observing this important
functionality. Adding a proper tracepoint provides a stable API for all
users who need visibility into TCP message transmission.

David Ahern is using a similar functionality with a custom patch[1]. So,
this means we have more than a single use case for this request, and it
might be a good idea to have such feature upstream.

Link: https://lore.kernel.org/all/70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Change to a full tracepoint inside tcp_sendmsg_locked(), heavily
  inspired in David's patch
- Link to v1: https://lore.kernel.org/r/20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org

---
Breno Leitao (2):
      net: pass const to msg_data_left()
      trace: tcp: Add tracepoint for tcp_sendmsg_locked()

 include/linux/socket.h     |  2 +-
 include/trace/events/tcp.h | 24 ++++++++++++++++++++++++
 net/ipv4/tcp.c             |  2 ++
 3 files changed, 27 insertions(+), 1 deletion(-)
---
base-commit: 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
change-id: 20250224-tcpsendmsg-4f0a236751d7

Best regards,
-- 
Breno Leitao <leitao@debian.org>


