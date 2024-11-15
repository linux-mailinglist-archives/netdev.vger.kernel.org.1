Return-Path: <netdev+bounces-145356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D89CF378
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5222528A13B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A61D6DC5;
	Fri, 15 Nov 2024 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HdDRlPSc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F0B156243
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693551; cv=none; b=GftYGLkyRESvNx/gipd8Rm8OJj4uJjqZtLkLk3Np/vrZuT99NckVFmD0SvgvVvu3qychWMJYeXWsaqhJ/eOKjOMb6B6s+HTnAEualTgVbwfJKPA2oEp4uidA3sTZysqaZiln9mwWNTjZGBbaQDuQLn7l1AyjUvZcy6wPV3nbwE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693551; c=relaxed/simple;
	bh=PuvzerMjZa+lsYbOLXG8QJGIgNH4trCNxumCNWcaoSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPXnGwmsGl3o5zE2uF1Jrg3iafBMu3uBj1KgPTrDkVH59hhBF+7nqTx8CjhIF8XJr0Of/zASfDUV9nNlXHKMm523z9BvWHzJYyVjy/+hBW268p5tqpSOpW21nd2E9Ke24APKHgCTizKhvj0qDHqoWO56qfPMyDaJZ4N+Ign9ap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HdDRlPSc; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id C0b0tmySFNywhC0b1tEybW; Fri, 15 Nov 2024 18:59:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731693545;
	bh=Ps2FThOUixFwqol5sm//odqUh2QyZm0LDBW7+hTu42o=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HdDRlPScaKBR+wWFU3QdNplFC8+tz6N7y4N2oIKPu0Cts2ZfDmYLAPdAtycK3vWhR
	 iYna7GNUJuJBtmjYMlgtdSs/hvHB8MG12BKynsnBsxvNmBoa4ZyfV7QEuLhDCs4r8J
	 d1P8oiRsuzLApKHVpKcNjtMImEjAT/8jXKKnUaH4olP9RjktNGbUJOzm/nv3HQze++
	 Sq2dcSnOkys5nT7byuM8pa8KXC/Fanph80hCJQgknHHIZlxhOoZ0DWzJIzyVw7cJgE
	 eZCpa7DaDZpR9D+QnBdxRfBcp/n6jtvP6VH37Ude+oBM6ve/hHJIlJINDs7OSsTknW
	 +hVWdYUuAM9hQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Nov 2024 18:59:05 +0100
X-ME-IP: 124.33.176.97
Message-ID: <31ea1d1b-dbe9-4bc6-8218-64de1884baaf@wanadoo.fr>
Date: Sat, 16 Nov 2024 02:59:01 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] add .editorconfig file for basic formatting
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>
References: <20241115151030.1198371-2-mailhol.vincent@wanadoo.fr>
 <20241115085150.62d239ae@hermes.local>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241115085150.62d239ae@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/11/2024 at 01:51, Stephen Hemminger wrote:
> On Sat, 16 Nov 2024 00:08:27 +0900
> Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> 
>> EditorConfig is a specification to define the most basic code formatting
>> stuff, and it is supported by many editors and IDEs, either directly or
>> via plugins, including VSCode/VSCodium, Vim, emacs and more.
>>
>> It allows to define formatting style related to indentation, charset,
>> end of lines and trailing whitespaces. It also allows to apply different
>> formats for different files based on wildcards, so for example it is
>> possible to apply different configurations to *.{c,h}, *.json or *.yaml.
>>
>> In linux related projects, defining a .editorconfig might help people
>> that work on different projects with different indentation styles, so
>> they cannot define a global style. Now they will directly see the
>> correct indentation on every fresh clone of the project.
>>
>> Add the .editorconfig file at the root of the iproute2 project. Only
>> configuration for the file types currently present are specified. The
>> automatic whitespace trimming option caused some issues in the Linux
>> kernel [1] and is thus not activated.
>>
>> See https://editorconfig.org
>>
>> [1] .editorconfig: remove trim_trailing_whitespace option
>> Link: https://git.kernel.org/torvalds/c/7da9dfdd5a3d
>>
>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> ---
>> For reference, here is the .editorconfig of the kernel:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/.editorconfig
>> ---
>>  .editorconfig | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644 .editorconfig
>>
>> diff --git a/.editorconfig b/.editorconfig
>> new file mode 100644
>> index 00000000..4cff39f1
>> --- /dev/null
>> +++ b/.editorconfig
>> @@ -0,0 +1,24 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +root = true
> 
> Maybe add something generic across all files. Then you only need to specify overrides

This is risky. Doing this will make the configuration apply to *all*
files with a risk of a "lost bullet". Are sure are we that some editor
will not misinterpret this on some kind of file?

This is why it was decided against it when doing the .editorconfig in
the Linux kernel and that instead, only what we are sure of should be
specified.

Maybe what I can propose as an alternative is to factorize the safe
option and still specify the indentation explicitly depending on the
file type:

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true

[{*.{c,h,sh},Makefile}]
indent_style = tab
indent_size = 8

[*.json]
indent_style = space
indent_size = 4

Thoughts?

> [*]
> end_of_line = lf
> insert_final_newline = true
> trim_trailing_whitespace = true

Just let me confirm this one: do you really want the automatic
whitespace removal? On some editor, it will trim not only the modified
lines but also any whitespace in the full file.

This can create "noise" in the patch diff. If you acknowledge this risk,
then I am fine to keep this parameter.

> charset = utf-8
> indent_style = tab
> tab_width = 8
> max_line_length = 100

This max_line_length can also have unexpected consequences. For example,
emacs will apply this parameter to the "fill commands", meaning that,
for example, when editing Markdown or README files, the paragraphs will
be warped at the 100th column. And I do not think that this is the
desired behavior.

If we want to keep the max_line_length, it is better to set it to the
desired default column wrap (e.g. 72 or 80, there is no strong consensus
here as far as I am aware).

>> +
>> +[{*.{c,h,sh},Makefile}]
>> +charset = utf-8
>> +end_of_line = lf
>> +insert_final_newline = true
>> +indent_style = tab
>> +indent_size = 8
>> +
>> +[*.json]
>> +charset = utf-8
>> +end_of_line = lf
>> +insert_final_newline = true
>> +indent_style = space
>> +indent_size = 4
>> +
>> +[*.yaml]
>> +charset = utf-8
>> +end_of_line = lf
>> +insert_final_newline = true
>> +indent_style = space
>> +indent_size = 2
> 

Yours sincerely,
Vincent Mailhol


