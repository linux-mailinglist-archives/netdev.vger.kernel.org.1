Return-Path: <netdev+bounces-95889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBA8C3C55
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03161C2121D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF60146D60;
	Mon, 13 May 2024 07:47:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from topaz.zyber.co.nz (topaz.zyber.co.nz [54.206.89.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF08146D54
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.89.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586479; cv=none; b=EwYH/vxGgDeedar32HrI3mAk1ioP4a5AsjnlY2ApzUmLRZJXHphb5dTxFSMNQebyIqBONWctwkbmDN6l2KQn/LKtaxZdxwdPkyc+2aVnAGhTNINUitdckwc98sWLsZnaC7F9giQL8fe2KIoVTXopyo3VncbQ7CVE5V83IJHEDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586479; c=relaxed/simple;
	bh=bbqAedXrvh/Cri/fdc2uzREFJSg5COM6fk6P7clPbyQ=;
	h=To:Subject:From:Date:Content-Type:Content-Disposition:
	 MIME-Version:Message-Id; b=VZsOcgBNK8r5DUVVhh1Sp53Rbk2FhCuMfDRH0rLW28GQTtIQaklDn2Qr+FeSbRo+yVhjVlxbWj+m56k/mGr1ptPXD6DlEvYIHSrD9wLLFA8VyDMPXqutzEqoGbXLSqON+AOnvkII5KAMxzqG5b/+BXLbaYJLZR2oUNXTEAagXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realconnections.co.nz; spf=none smtp.mailfrom=realconnections.co.nz; arc=none smtp.client-ip=54.206.89.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realconnections.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=realconnections.co.nz
Received: by topaz.zyber.co.nz (Postfix, from userid 10058)
	id 138298D6BD; Mon, 13 May 2024 19:38:28 +1200 (NZST)
To: netdev@vger.kernel.org
Subject: Contact Us Form Submission
X-PHP-Originating-Script: 10058:Sendmail.php
From: info@realconnections.co.nz
Date: Mon, 13 May 2024 19:38:28 +1200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20240513073828.138298D6BD@topaz.zyber.co.nz>

We have successfully received your Contact Us message on our website.=0D=
=0A=0D=0AThe following information was provided:=0D=0A=0D=0AName: Bahusa=
sp=0D=0A=0D=0AEmail Address: netdev@vger.kernel.org=0D=0A=0D=0APhone: 84=
818823281=0D=0A=0D=0AMessage: Hi, this is Jenny. I am sending you my int=
imate photos as I promised. https://tinyurl.com/28xm4x5h#m1aWQK=0D=0A=0D=
=0A=0D=0AThank you very much for your submission.=0D=0A

